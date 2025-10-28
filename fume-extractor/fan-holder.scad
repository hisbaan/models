include <BOSL2/std.scad>;

$fn = $preview ? 64 : 256;
epsilon = 0.002;

module fan_holder(
  fan_size = 120 + 1,
  fan_thickness = 25,
  wall_thickness = 2,
  screw_diameter = 3.6,
  screw_spacing_from_corner = 8,
  screw_chamfer = -1.6,
  cutout_size = 10,
  cutout_offset = 4,
  joiner_height = 2,
  joiner_thickness = 1.2
) {
  close_corner_coords = screw_spacing_from_corner + wall_thickness;
  far_corner_coords = fan_size + wall_thickness - screw_spacing_from_corner;

  screw_hole_height = wall_thickness + 2 * epsilon;
  screw_hole_radius = screw_diameter / 2;

  difference() {
    difference() {
      difference() {
        difference() {
          difference() {
            difference() {
              difference() {
                // main box
                cuboid([fan_size + wall_thickness * 2, fan_size + wall_thickness * 2, fan_thickness + wall_thickness], anchor=BOTTOM + LEFT + FRONT, chamfer=0.4);
                translate([wall_thickness, wall_thickness, wall_thickness])
                  cuboid([fan_size, fan_size, fan_thickness + epsilon], anchor=BOTTOM + LEFT + FRONT, chamfer=-0.4, edges=TOP);
              }
              // circle cutout
              translate([fan_size / 2 + wall_thickness, fan_size / 2 + wall_thickness, -epsilon])
                cyl(h=wall_thickness + 2 * epsilon, r=fan_size / 2, anchor=BOTTOM, chamfer=-0.4);
            }
            translate([fan_size - cutout_size + wall_thickness - cutout_offset, fan_size + wall_thickness - epsilon, cutout_offset + wall_thickness])
              cuboid([cutout_size, wall_thickness + 2 * epsilon, cutout_size], anchor=BOTTOM + LEFT + FRONT);
          }
          // (0, 0) screw hole
          translate([close_corner_coords, close_corner_coords, -epsilon])
            cyl(h=screw_hole_height, r=screw_hole_radius, anchor=BOTTOM, chamfer1=screw_chamfer);
        }
        // (1, 0) screw hole
        translate([far_corner_coords, close_corner_coords, -epsilon])
          cyl(h=screw_hole_height, r=screw_hole_radius, anchor=BOTTOM, chamfer1=screw_chamfer);
      }
      // (0, 1) screw hole
      translate([close_corner_coords, far_corner_coords, -epsilon])
        cyl(h=screw_hole_height, r=screw_hole_radius, anchor=BOTTOM, chamfer1=screw_chamfer);
    }
    // (1, 1) screw hole
    translate([far_corner_coords, far_corner_coords, -epsilon])
      cyl(h=screw_hole_height, r=screw_hole_radius, anchor=BOTTOM, chamfer1=screw_chamfer);
  }

  difference() {
    translate([
      wall_thickness,
      fan_size + 2 * wall_thickness,
      wall_thickness
    ])
      cuboid(
        [
          fan_size,
          joiner_height,
          fan_thickness - wall_thickness
        ],
        anchor=BOTTOM+LEFT+FRONT,
        chamfer = 0.4,
        edges = [BACK, TOP+RIGHT, TOP+LEFT, BOTTOM+RIGHT, BOTTOM+LEFT]
      );
    translate([
      wall_thickness + joiner_thickness,
      fan_size + 2 * wall_thickness - epsilon,
      wall_thickness + joiner_thickness
    ])
      cuboid(
        [
          fan_size - 2 * joiner_thickness,
          joiner_height + 2 * epsilon,
          fan_thickness - wall_thickness - joiner_thickness * 2
        ],
        anchor=BOTTOM+LEFT+FRONT
      );
  }
}

fan_holder();
