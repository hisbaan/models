include <BOSL2/std.scad>;

$fn = $preview ? 64 : 256;
epsilon = 0.002;

magnet_vert_padding = 2;
magnet_horiz_padding = 1;
magnet_radius = 3.1;
magnet_height = 2.2;

hook_diameter = 15;
hook_thickness = 3;

J_extension = 3;

anchor_positive = FRONT + LEFT + BOTTOM;

I_length = 4 * magnet_radius + 3 * magnet_vert_padding;
I_width = 2 * magnet_radius + 2 * magnet_horiz_padding;

union() {
  // J extension
  translate([I_length - 2 * J_extension, hook_thickness + (hook_diameter - 2 * hook_thickness) - epsilon, 0])
    cuboid([J_extension * 2, hook_thickness, I_width], anchor=anchor_positive, chamfer=0.5, edges=[BACK + BOTTOM, BACK + TOP, LEFT]);

  difference() {
    // main body
    union() {
      cuboid([I_length, hook_thickness, I_width], anchor=anchor_positive, chamfer=0.5, edges=[FRONT + BOTTOM, FRONT + TOP, LEFT]);
      translate([I_length, hook_diameter / 2, 0])
        cyl(h=I_width, d=hook_diameter, anchor=BOTTOM, chamfer=0.5);
    }

    // hook cutouts
    translate([I_length, hook_diameter / 2, -epsilon])
      cyl(h=I_width + 2 * epsilon, d=hook_diameter - 2 * hook_thickness, anchor=BOTTOM);
    translate([0, hook_thickness, -epsilon])
      cuboid([I_length, hook_diameter - 2 * hook_thickness, I_width + 2 * epsilon], anchor=anchor_positive);
    translate([0, hook_thickness + (hook_diameter - 2 * hook_thickness) - epsilon, -epsilon])
      cuboid([I_length - J_extension, hook_diameter - hook_thickness, I_width + 2 * epsilon], anchor=anchor_positive);

    // magnet holes
    translate([magnet_vert_padding + magnet_radius, magnet_height / 2 - epsilon, magnet_horiz_padding + magnet_radius])
      rotate([90, 0, 0])
        cyl(h=magnet_height, r=magnet_radius);
    translate([2 * magnet_vert_padding + 3 * magnet_radius, magnet_height / 2 - epsilon, magnet_horiz_padding + magnet_radius])
      rotate([90, 0, 0])
        cyl(h=magnet_height, r=magnet_radius);
  }
}
