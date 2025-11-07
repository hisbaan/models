include <BOSL2/std.scad>;
include <chamfer-extrude.scad>;

$fn = $preview ? 64 : 256;
epsilon = 0.002;

key_x = 13.8;
key_y = 13.8;

key_padding_x = 2.1;
key_padding_y = 2.1;

key_outer_border = 1.98;

space_between_keys = 1;

kx = 19;
ky = 19;

pcb_thickness = 1.6;
plate_thickness = 1.2;
plate_pcb_gap = 1.35;

pcb_tolerance = 1;
case_wall_thickness = 3;
chamfer_size = case_wall_thickness / 2;
case_floor_thickness = 2;
case_height = pcb_thickness + plate_thickness + plate_pcb_gap;
outer_padding = pcb_tolerance + case_wall_thickness;

pcb_x = 133.755;
pcb_y = 91.7155;

hotswap_socket_height = 1.9;

module case() {
  // first key bottom left coord
  fx = 97.01;
  fy = 6.73;

  index_stagger = -0.125;
  middle_stagger = -0.250;
  ring_stagger = -0.125;
  pinkie_stagger = 0.125;
  outer_stagger = 0.125;

  key_corners = [
    // inner
    [[fx, fy], 0],
    [[fx, fy + ky], 0],
    [[fx, fy + 2 * ky], 0],
    // index
    [[fx - kx, fy + index_stagger * ky], 0],
    [[fx - kx, fy + ky + index_stagger * ky], 0],
    [[fx - kx, fy + 2 * ky + index_stagger * ky], 0],
    // middle
    [[fx - 2 * kx, fy + middle_stagger * ky], 0],
    [[fx - 2 * kx, fy + ky + middle_stagger * ky], 0],
    [[fx - 2 * kx, fy + 2 * ky + middle_stagger * ky], 0],
    // ring
    [[fx - 3 * kx, fy + ring_stagger * ky], 0],
    [[fx - 3 * kx, fy + ky + ring_stagger * ky], 0],
    [[fx - 3 * kx, fy + 2 * ky + ring_stagger * ky], 0],
    // pinkie
    [[fx - 4 * kx, fy + pinkie_stagger * ky], 0],
    [[fx - 4 * kx, fy + ky + pinkie_stagger * ky], 0],
    [[fx - 4 * kx, fy + 2 * ky + pinkie_stagger * ky], 0],
    // outer
    [[fx - 5 * kx, fy + outer_stagger * ky], 0],
    [[fx - 5 * kx, fy + ky + outer_stagger * ky], 0],
    [[fx - 5 * kx, fy + 2 * ky + outer_stagger * ky], 0],
    // thumb
    [[fx - kx - key_padding_x - space_between_keys / 2 - key_x / 2, fy + 2 * ky + 17.25], 0],
    [[fx - key_padding_x - space_between_keys / 2 - key_x / 2 + 4.0311, fy + 2 * ky + 18.4535], 15],
    [[fx + kx - key_padding_x - space_between_keys / 2 - key_x / 2 + 9.625 - 6.89, fy + 2 * ky + 21.25 + 11.95], 30 - 90],
  ];
  if ($preview) {
    translate([outer_padding, outer_padding, 5])
      union() {
        for (key_corner = key_corners) {
          marker(key_corner[0]);
        }
      }
  }

  screw_coords = [
    [18.42, 25.51],
    [18.42, 44.51],
    [94.4, 22],
    [61.575, 61.75],
    [108.17, 69.34],
  ];

  case_corners = [
    [0, 7],
    [key_padding_x * 4 + space_between_keys * 2 + key_x * 2, 7],
    [key_padding_x * 4 + space_between_keys * 2 + key_x * 2, 2.25],
    [key_padding_x * 6 + space_between_keys * 3 + key_x * 3, 2.25],
    [key_padding_x * 6 + space_between_keys * 3 + key_x * 3, 0],
    [key_padding_x * 8 + space_between_keys * 3 + key_x * 4, 0],
    [key_padding_x * 8 + space_between_keys * 3 + key_x * 4, 2.25],
    [key_padding_x * 10 + space_between_keys * 4 + key_x * 5, 2.25],
    [key_padding_x * 10 + space_between_keys * 4 + key_x * 5, 4.75],
    [key_padding_x * 12 + space_between_keys * 5 + key_x * 6, 4.75],
    [key_padding_x * 12 + space_between_keys * 5 + key_x * 6, 7],
    [key_padding_x * 12 + space_between_keys * 5 + key_x * 6 + 20.75, 7],
    [key_padding_x * 12 + space_between_keys * 5 + key_x * 6 + 20.75, 67.5],
    [key_padding_x * 12 + space_between_keys * 5 + key_x * 6 + 6.625, 91.8925],
    [key_padding_x * 11 + space_between_keys * 5 + key_x * 5.5, 83],
    [key_padding_x * 10 + space_between_keys * 4 + key_x * 3, 77.75],
    [key_padding_x * 6 + space_between_keys * 1.75 + key_x * 3, 63.25],
    [0, 63.25],
  ];
  if ($preview) {
    translate([outer_padding, outer_padding, 5])
      union() {
        for (case_corner = case_corners) {
          marker(case_corner);
        }
      }
  }

  translate([outer_padding, outer_padding, 0])
    difference() {
      union() {
        translate([0, 0, case_height + case_floor_thickness - chamfer_size - epsilon])
          chamfer_extrude(height = chamfer_size, angle = 45, center = false, $fn = 64)
            offset(r = case_wall_thickness + pcb_tolerance - 1.5)
              polygon(case_corners);
        linear_extrude(h=case_height + case_floor_thickness - chamfer_size)
          offset(r=case_wall_thickness + pcb_tolerance)
            polygon(case_corners);
      }

      // case inside
      translate([0, 0, case_floor_thickness])
        linear_extrude(h=case_height + case_floor_thickness - case_floor_thickness + 2 * epsilon + 1)
          offset(r=pcb_tolerance)
            polygon(case_corners);

      // hotswap sockets
      for (key_corner = key_corners) {
        translated_hotswap_socket(key_corner[0], key_corner[1], [1.1, 1.1, 1.1]);
      }

      for (key_corner = key_corners) {
        translated_switch_pin_recess(key_corner[0], key_corner[1]);
      }

      for (key_corner = key_corners) {
        translated_diode(key_corner[0], key_corner[1]);
      }

      // pins
      translate([pcb_x - 1, 10.65, case_floor_thickness - 1.3]) nice_nano_pins();
      translate([pcb_x - 15.9, 10.65, case_floor_thickness - 1.3]) nice_nano_pins();

      translate([pcb_x - 3.65, 42.65, case_floor_thickness - 1.3]) nice_view_pins();

      translate([pcb_x - 9.5, 49.5, case_floor_thickness - 1.3]) jst_pins();

      // screw holes
      for (screw_coord = screw_coords) {
        translated_standoff_cutout(screw_coord);
      }
      for (screw_coord = screw_coords) {
        screw_holes(screw_coord);
      }

      // wall cutouts
      translate([pcb_x + pcb_tolerance - 0.1, 34.75 + 7, case_floor_thickness + pcb_thickness])
        switch_cutout();

      translate([pcb_x - 5.2, 7 - pcb_tolerance - case_wall_thickness - 0.1, case_floor_thickness + pcb_thickness])
        usb_and_reset_switch_cutout();
    }
}

module marker(coord = [0, 0]) {
  translate(coord)
    union() {
      translate([-0.5, -0.5, 0]) color([0.5, 0.5, 0]) cuboid([1, 1, 1]);
      translate([0.5, -0.5, 0]) color([0, 0.5, 1]) cuboid([1, 1, 1]);
      translate([-0.5, 0.5, 0]) color([0.5, 0, 0.5]) cuboid([1, 1, 1]);
      translate([0.5, 0.5, 0]) color([0, 0, 0]) cuboid([1, 1, 1]);
    }
}

module frontplate(choc_version = "choc-v2", thickness = 1.2) {
  import_path = choc_version == "choc-v2" ? "./choc-v2/frontplate.dxf" : "./choc-v1/frontplate.dxf";
  linear_extrude(height=thickness) rotate([180, 0, 0]) import(import_path, center=true);
}

module pcb(choc_version = "choc-v2", thickness = 1.6) {
  import_path = choc_version == "choc-v2" ? "./choc-v2/pcb.dxf" : "./choc-v1/pcb.dxf";
  linear_extrude(height=thickness) rotate([180, 0, 0]) import(import_path, center=true);
}

module frontplate_and_pcb() {
  if ($preview) {
    translate([pcb_x / 2 + outer_padding, pcb_y / 2 + outer_padding, case_floor_thickness])
      union() {
        color([0.75, 0, 0]) translate([-0.25, 0, plate_thickness + plate_pcb_gap]) frontplate();
        color([0, 0.5, 0.5]) translate([0, 0, 0]) pcb(thickness=pcb_thickness);
      }
  }
}

module hotswap_socket(scale_matrix = [1, 1, 1]) {
  color([0, 0.75, 0.75])
    union() {
      translate(
        [
          2.165 * scale_matrix[0],
          -1.36 * scale_matrix[1],
          1.85 * scale_matrix[2] - 2 * epsilon,
        ]
      )
        rotate([180, 0, 270])
          scale(scale_matrix)
            import("./kailh-choc-socket.stl", center=false);
      translate([7.18, -2, -epsilon])
        cuboid([3.027, 2.975, 2.035], anchor=BOTTOM + LEFT + BACK);
    }
}

module translated_hotswap_socket(key_corner = [0, 0], angle = 0, scale_matrix = [1, 1, 1]) {
  translate([key_corner[0], key_corner[1], 0]) rotate([0, 0, angle]) translate([key_x / 2, key_y / 2 + 5.29, 0]) hotswap_socket(scale_matrix);
}

module translated_diode(key_corner = [0, 0], angle = 0) {
  translate([key_corner[0], key_corner[1], 0])
    color([0, 0.75, 0.75])
      rotate(angle)
        translate([key_x / 2 + 7, key_y / 2 + 2, case_floor_thickness + 2 * epsilon])
          cuboid([2.1, 6, 1], anchor=TOP + LEFT + BACK);
}

module nice_nano_pins() {
  color([0, 0.75, 0.75]) cuboid([2.5, 30.5, 1.3 + epsilon], anchor=FRONT + RIGHT + BOTTOM);
}

module nice_view_pins() {
  color([0, 0.75, 0.75]) cuboid([12.5, 4.75, 1.3 + epsilon], anchor=FRONT + RIGHT + BOTTOM);
}

module jst_pins() {
  color([0, 0.75, 0.75]) cuboid([4.75, 4.35, 1.3 + epsilon], anchor=FRONT + RIGHT + BOTTOM);
}

module translated_switch_pin_recess(key_corner = [0, 0], angle = 0) {
  translate([key_corner[0], key_corner[1], 0])
    color([0, 0.75, 0.75])
      rotate(angle)
        translate([key_x / 2, key_y / 2, case_floor_thickness + 2 * epsilon])
          cyl(h=1 + epsilon, r=1.6, anchor=TOP);
}

module translated_standoff_cutout(pos = [0, 0]) {
  translate([pos[0], pos[1], case_floor_thickness + 2 * epsilon])
    cyl(h=1.2, r=1.45, anchor=TOP);
}

module screw_holes(pos = [0, 0]) {
  translate([pos[0], pos[1], -epsilon])
    cyl(h=case_floor_thickness + 2 * epsilon, r=1, anchor=BOTTOM);
}

module switch_cutout() {
  cuboid(
    [
      case_wall_thickness + 0.2,
      15,
      case_height - pcb_thickness
    ],
    anchor=BOTTOM+LEFT+FRONT,
    chamfer = -chamfer_size,
    edges = [TOP+RIGHT, TOP+FRONT, TOP+BACK]
  );
}

module usb_and_reset_switch_cutout() {
  cuboid(
    [
      9,
      case_wall_thickness + 0.2,
      case_height - pcb_thickness
    ],
    anchor=BOTTOM+RIGHT+FRONT,
    chamfer = -chamfer_size,
    edges = [TOP+FRONT, TOP+LEFT, TOP+RIGHT]
  );
}

frontplate_and_pcb();

case();
