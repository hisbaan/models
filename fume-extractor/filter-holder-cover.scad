include <BOSL2/std.scad>;
use <clip.scad>;

$fn = $preview ? 64 : 256;
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
    outer_dim = fan_size + 2 * wall_thickness;
    cuboid([outer_dim, outer_dim, wall_thickness], anchor=BOTTOM+LEFT+FRONT, chamfer=0.4);

    inner_dim = fan_size - 2 * lip_size;
    translate(
      [
        lip_size + wall_thickness,
        lip_size + wall_thickness,
        - epsilon,
      ]
    )
      cuboid([inner_dim, inner_dim, wall_thickness + 4 * epsilon], anchor=BOTTOM+LEFT+FRONT, chamfer=-0.4);
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

filter_holder_cover(fan_size=20, lip_size=5);
