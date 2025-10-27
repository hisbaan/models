epsilon = 0.002;

module fan_holder(fan_size = 120, fan_thickness = 25, wall_thickness = 2, screw_diameter = 5, screw_spacing_from_corner = 8) {
  close_corner_coords = screw_spacing_from_corner - screw_diameter / 2 + wall_thickness;
  far_corner_coords = fan_size + wall_thickness - screw_spacing_from_corner + screw_diameter / 2;

  difference() {
    difference() {
      difference() {
        difference() {
          difference() {
            difference() {
              // main box
              // TODO fillet corners
              cube([fan_size + wall_thickness * 2, fan_size + wall_thickness * 2, fan_thickness + wall_thickness]);
              translate([wall_thickness, wall_thickness, wall_thickness])
                cube([fan_size, fan_size, fan_thickness + epsilon]);
            }
            // circle cutout
            translate([fan_size / 2 + wall_thickness, fan_size / 2 + wall_thickness, -epsilon])
              cylinder(h=wall_thickness + 2 * epsilon, r=fan_size / 2);
            // TODO fillet corners of the cutout too
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
  // TODO hole in the wall here for the power cables to pass into the base
}

fan_holder();
