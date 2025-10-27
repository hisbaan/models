use <clip.scad>;

$fn = 64;
epsilon = 0.002;

module filter_holder(
  fan_size = 120,
  filter_thickness = 10,
  wall_thickness = 2,
  screw_diameter = 5,
  screw_spacing_from_corner = 8,
  clip_height = 6,
  clip_width = 2.4,
  clip_thickness = 1.2,
  clip_detent_size = 1.2,
) {
  close_corner_coords = screw_spacing_from_corner - screw_diameter / 2 + wall_thickness;
  far_corner_coords = fan_size + wall_thickness - screw_spacing_from_corner + screw_diameter / 2;

  clip_close_x = wall_thickness + clip_width / 2;
  clip_close_y = wall_thickness + clip_thickness / 2;
  clip_far_x = fan_size + wall_thickness - clip_width / 2;
  clip_far_y = fan_size + wall_thickness - clip_thickness / 2;

  difference() {
    difference() {
      difference() {
        difference() {
          difference() {
            difference() {
              difference() {
                difference() {
                  difference() {
                    // main box
                    difference() {
                      cube([fan_size + wall_thickness * 2, fan_size + wall_thickness * 2, filter_thickness + wall_thickness]);
                      translate([wall_thickness, wall_thickness, wall_thickness])
                        cube([fan_size, fan_size, filter_thickness + epsilon]);
                    }
                    // circle cutout
                    translate([fan_size / 2 + wall_thickness, fan_size / 2 + wall_thickness, -epsilon])
                      cylinder(h=wall_thickness + 2 * epsilon, r=fan_size / 2);
                  }
                  // (0, 0) screw hole
                  translate([close_corner_coords, close_corner_coords, -epsilon])
                    cylinder(h=wall_thickness + 2 * epsilon, r=screw_diameter / 2);
                }
                // (1, 0) screw hole
                translate([far_corner_coords, close_corner_coords, -epsilon])
                  cylinder(h=wall_thickness + 2 * epsilon, r=screw_diameter / 2);
              }
              // (0, 1) screw hole
              translate([close_corner_coords, far_corner_coords, -epsilon])
                cylinder(h=wall_thickness + 2 * epsilon, r=screw_diameter / 2);
            }
            // (1, 1) screw hole
            translate([far_corner_coords, far_corner_coords, -epsilon])
              cylinder(h=wall_thickness + 2 * epsilon, r=screw_diameter / 2);
          }
          // clip cutout (0, 0)
          translate([clip_close_x, clip_close_y, filter_thickness + wall_thickness])
            rotate([180, 0, 0])
              clip();
        }
        // clip cutout (0, 1)
        translate([clip_close_x, clip_far_y, filter_thickness + wall_thickness])
          rotate([0, 180, 0])
            clip();
      }
      // clip cutout (1, 0)
      translate([clip_far_x, clip_close_y, filter_thickness + wall_thickness])
        rotate([180, 0, 0])
          clip();
    }
    // clip cutout (1, 1)
    translate([clip_far_x, clip_far_y, filter_thickness + wall_thickness])
      rotate([0, 180, 0])
        clip();
  }
}

filter_holder(20);
