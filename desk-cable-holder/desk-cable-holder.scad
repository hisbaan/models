include <BOSL2/std.scad>;

$fn = $preview ? 64 : 256;
epsilon = 0.002;

layer_height = 0.16;
magnet_radius = 3.1;
magnet_height = 2.2;
magnet_horiz_padding = 2;
magnet_vert_padding = layer_height * 3;
holder_length = 125;
holder_width = magnet_radius * 2 + magnet_horiz_padding * 2;
holder_thickness = magnet_height + magnet_vert_padding * 2;

magnet_offset = holder_length / 2 - magnet_radius - magnet_horiz_padding;

difference() {
  cuboid([holder_length, holder_width, holder_thickness], chamfer=0.5);
  union() {
    translate([magnet_offset, 0, 0]) cyl(h=magnet_height, r=magnet_radius);
    translate([-magnet_offset, 0, 0]) cyl(h=magnet_height, r=magnet_radius);
  }
}
