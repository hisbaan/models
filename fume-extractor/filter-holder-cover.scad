include <BOSL2/std.scad>;
use <clip.scad>;

$fn = $preview ? 64 : 256;
epsilon = 0.002;

module filter_holder_cover(
  fan_size = 120 + 1,
  wall_thickness = 2,
  lip_size = 10,
  joiner_height = 2,
  joiner_thickness = 1.2,
) {
  // main surface
  difference() {
    outer_dim = fan_size + 2 * wall_thickness;
    cuboid([outer_dim, outer_dim, wall_thickness], anchor=BOTTOM + LEFT + FRONT, chamfer=0.4);

    inner_dim = fan_size - 2 * lip_size;
    translate(
      [
        lip_size + wall_thickness,
        lip_size + wall_thickness,
        -epsilon,
      ]
    )
      cuboid([inner_dim, inner_dim, wall_thickness + 4 * epsilon], anchor=BOTTOM + LEFT + FRONT, chamfer=-0.4);
  }

  // joiner
  difference() {
    translate([wall_thickness, wall_thickness, wall_thickness])
      cuboid([fan_size, fan_size, joiner_height], anchor=BOTTOM + LEFT + FRONT, chamfer=0.4, edges=TOP);
    translate([wall_thickness + joiner_thickness, wall_thickness + joiner_thickness, -epsilon + wall_thickness])
      cuboid([fan_size - 2 * joiner_thickness, fan_size - 2 * joiner_thickness, joiner_height + 2 * epsilon] , anchor=BOTTOM+LEFT+FRONT, chamfer = -0.4, edges = TOP);
  }
}

filter_holder_cover();
