include <BOSL2/std.scad>;
include <chamfer-extrude.scad>;

$fn = $preview ? 64 : 256;
epsilon = 0.002;

key_x = 13.8;
key_y = 13.8;

key_padding_x = 2.1;
key_padding_y = 2.1;

key_height = 10;
case_height = 8.1;

space_between_keys = 1;

pcb_tolerance = 1;
inner_case_wall_thickness = 3;
wall_thickness = 4;
floor_thickness = 2;
tolerance = 1;

magnet_height_tolerance = 0.1;
magnet_height = 2 + magnet_height_tolerance;
magnet_diameter_tolerance = 0.2;
magnet_diameter = 6 + magnet_diameter_tolerance;
magnet_offset_from_corner = 2.5;
magnet_offset = magnet_diameter / 2 + magnet_offset_from_corner;

outer_padding = pcb_tolerance + inner_case_wall_thickness + wall_thickness + tolerance;

box_x = key_padding_x * 12 + space_between_keys * 5 + key_x * 6 + 20.75 + 2 * (inner_case_wall_thickness + pcb_tolerance + 1 + wall_thickness);
box_y = 2 * (91.8925 + 2 * (inner_case_wall_thickness + pcb_tolerance + 1) + wall_thickness + 1);
box_z = case_height + key_height + floor_thickness;

module carrying_case() {
  difference() {
    union() {
      cuboid(
        [
          box_x,
          box_y,
          box_z,
        ],
        anchor=FRONT + LEFT + BOTTOM,
        chamfer=2
      );
    }
    cutout();
    translate([0, 2 * (91.8925 + 2 * (inner_case_wall_thickness + pcb_tolerance + 1) + wall_thickness + 1), 0]) mirror([0, 1, 0]) cutout();
    union() {
      // magnets
      translate([box_x - magnet_offset, box_y - magnet_offset, box_z + epsilon]) magnet(height=magnet_height, diameter=magnet_diameter);
      translate([magnet_offset, box_y - magnet_offset, box_z + epsilon]) magnet(height=magnet_height, diameter=magnet_diameter);
      translate([box_x - magnet_offset, magnet_offset, box_z + epsilon]) magnet(height=magnet_height, diameter=magnet_diameter);
      translate([magnet_offset, magnet_offset, box_z + epsilon]) magnet(height=magnet_height, diameter=magnet_diameter);
    }
  }
}

module cutout() {
  pcb_corners = [
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

  translate([outer_padding, outer_padding, floor_thickness + epsilon])
    union() {
      translate([0, 0, key_height])
        linear_extrude(h=case_height)
          offset(r=inner_case_wall_thickness + pcb_tolerance + 1)
            polygon(pcb_corners);
      linear_extrude(h=case_height + key_height)
        offset(1)
          polygon(pcb_corners);
    }
}

module magnet(height = 2, diameter = 6) {
  cyl(h=height, d=diameter, anchor=TOP);
}

module left_carrying_case() {
  difference() {
    carrying_case();
    translate([-epsilon, box_y / 2, -epsilon]) cuboid(
        [
          box_x + 2 * epsilon,
          box_y / 2 + epsilon,
          box_z + 2 * epsilon,
        ], anchor=FRONT + LEFT + BOTTOM
      );
  }
}

module right_carrying_case() {
  // TODO mirror or take the other side or smth
  difference() {
    carrying_case();
    translate([-epsilon, box_y / 2, -epsilon]) cuboid(
        [
          box_x + 2 * epsilon,
          box_y / 2 + epsilon,
          box_z + 2 * epsilon,
        ], anchor=FRONT + LEFT + BOTTOM
      );
  }
}

left_carrying_case();
