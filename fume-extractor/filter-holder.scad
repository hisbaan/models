include <BOSL2/std.scad>;
use <clip.scad>;

$fn = $preview ? 64 : 256;
epsilon = 0.002;

module filter_holder(
  fan_size = 120 + 1,
  filter_thickness = 10,
  wall_thickness = 2,
  screw_diameter = 3.6,
  screw_spacing_from_corner = 8,
  screw_chamfer = -1.6,
  joiner_height = 2,
) {
  close_corner_coords = screw_spacing_from_corner - screw_diameter / 2 + wall_thickness;
  far_corner_coords = fan_size + wall_thickness - screw_spacing_from_corner + screw_diameter / 2;

  box_height = filter_thickness + joiner_height;

  screw_hole_height = wall_thickness + 2 * epsilon;
  screw_hole_radius = screw_diameter / 2;

  difference() {
    difference() {
      difference() {
        difference() {
          difference() {
            // main box
            difference() {
              cuboid([fan_size + wall_thickness * 2, fan_size + wall_thickness * 2, box_height + wall_thickness], anchor=BOTTOM + LEFT + FRONT, chamfer=0.4);
              translate([wall_thickness, wall_thickness, wall_thickness])
                cuboid([fan_size, fan_size, box_height + epsilon], anchor=BOTTOM + LEFT + FRONT, chamfer=-0.4, edges=TOP);
            }
            // circle cutout
            translate([fan_size / 2 + wall_thickness, fan_size / 2 + wall_thickness, -epsilon])
              cyl(l=wall_thickness + 2 * epsilon, r=fan_size / 2, anchor=BOTTOM, chamfer=-0.4);
          }
          // (0, 0) screw hole
          // TODO measure screw, set correct chamfer, diameter, etc
          translate([close_corner_coords, close_corner_coords, -epsilon])
            cyl(h=screw_hole_height, r=screw_hole_radius, anchor=BOTTOM, chamfer2=screw_chamfer);
        }
        // (1, 0) screw hole
        translate([far_corner_coords, close_corner_coords, -epsilon])
          cyl(h=screw_hole_height, r=screw_hole_radius, anchor=BOTTOM, chamfer2=screw_chamfer);
      }
      // (0, 1) screw hole
      translate([close_corner_coords, far_corner_coords, -epsilon])
        cyl(h=screw_hole_height, r=screw_hole_radius, anchor=BOTTOM, chamfer2=screw_chamfer);
    }
    // (1, 1) screw hole
    translate([far_corner_coords, far_corner_coords, -epsilon])
      cyl(h=screw_hole_height, r=screw_hole_radius, anchor=BOTTOM, chamfer2=screw_chamfer);
  }
}

filter_holder();
