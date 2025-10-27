use <BOSL2/std.scad>;
use <clip.scad>;
$fn = 64;
epsilon = 0.002;

module filter_holder_cover(
  fan_size = 120,
  wall_thickness = 2,
  lip_size = 10,
  clip_height = 6,
  clip_width = 2.4,
  clip_thickness = 1.2,
  clip_detent_size = 1.2,
) {
  difference() {
    cube([fan_size + 2 * wall_thickness, fan_size + 2 * wall_thickness, wall_thickness]);
    translate([lip_size + wall_thickness, lip_size + wall_thickness, -epsilon])
      cube([fan_size - 2 * lip_size, fan_size - 2 * lip_size, wall_thickness + 2 * epsilon]);
  }

  close_x = wall_thickness + clip_width / 2;
  close_y = wall_thickness + clip_thickness / 2;
  far_x = fan_size + wall_thickness - clip_width / 2;
  far_y = fan_size + wall_thickness - clip_thickness / 2;

  translate([close_x, close_y, wall_thickness])
    rotate([0, 0, 180])
      clip(height=clip_height, thickness=clip_thickness, width=clip_width, detent_size=clip_detent_size);

  translate([far_x, close_y, wall_thickness])
    rotate([0, 0, 180])
      clip(height=clip_height, thickness=clip_thickness, width=clip_width, detent_size=clip_detent_size);

  translate([close_x, far_y, wall_thickness])
    clip(height=clip_height, thickness=clip_thickness, width=clip_width, detent_size=clip_detent_size);

  translate([far_x, far_y, wall_thickness])
    clip(height=clip_height, thickness=clip_thickness, width=clip_width, detent_size=clip_detent_size);
}

filter_holder_cover(fan_size = 20, lip_size = 5);
