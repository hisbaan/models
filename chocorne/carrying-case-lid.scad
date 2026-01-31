include <BOSL2/std.scad>;
include <chamfer-extrude.scad>;

$fn = $preview ? 64 : 256;
epsilon = 0.002;

key_x = 13.8;
key_y = 13.8;

key_padding_x = 2.1;
key_padding_y = 2.1;

case_lid_height = 3;

space_between_keys = 1;

pcb_tolerance = 1;
inner_case_wall_thickness = 3;
wall_thickness = 4;

magnet_height_tolerance = 0.1;
magnet_height = 2 + magnet_height_tolerance;
magnet_diameter_tolerance = 0.2;
magnet_diameter = 6 + magnet_diameter_tolerance;
magnet_offset_from_corner = 2.5;
magnet_offset = magnet_diameter / 2 + magnet_offset_from_corner;

module carrying_case_lid(magnets_top = true) {
  box_x = key_padding_x * 12 + space_between_keys * 5 + key_x * 6 + 20.75 + 2 * (inner_case_wall_thickness + pcb_tolerance + 1 + wall_thickness);
  box_y = 2 * (91.8925 + 2 * (inner_case_wall_thickness + pcb_tolerance + 1) + wall_thickness + 1);
  box_z = case_lid_height;

  magnet_z = magnets_top ? box_z + epsilon : magnet_height - epsilon;
  clip_offset = magnets_top ? box_x : 0;
  hole_offset = magnets_top ? 0 : box_x;

  difference() {
    union() {
      cuboid(
        [
          box_x,
          box_y / 2,
          box_z,
        ],
        anchor=FRONT + LEFT + BOTTOM,
        edges=[LEFT + TOP + BOTTOM, RIGHT + TOP + BOTTOM, FRONT + TOP + BOTTOM],
        chamfer=1
      );
      translate([0, box_y / 2, 1.5]) union() {
        translate([abs(clip_offset - 11), 0, 0]) connector();
        translate([abs(clip_offset - 31), 0, 0]) connector();
        translate([abs(clip_offset - 51), 0, 0]) connector();
        translate([abs(clip_offset - 71), 0, 0]) connector();
        translate([abs(clip_offset - 91), 0, 0]) connector();
        translate([abs(clip_offset - 111), 0, 0]) connector();
        translate([abs(clip_offset - 131), 0, 0]) connector();
        }
    }

    union() {
      // magnets
      // translate([box_x - magnet_offset, box_y - magnet_offset, box_z + epsilon]) magnet(height=magnet_height, diameter=magnet_diameter);
      // translate([magnet_offset, box_y - magnet_offset, box_z + epsilon]) magnet(height=magnet_height, diameter=magnet_diameter);
      translate([box_x - magnet_offset, magnet_offset, magnet_z]) magnet(height=magnet_height, diameter=magnet_diameter);
      translate([magnet_offset, magnet_offset, magnet_z]) magnet(height=magnet_height, diameter=magnet_diameter);
      translate([0, box_y / 2, 1.5]) rotate([180, 0, 0]) union() {
        translate([abs(hole_offset - 11), 0, 0]) scale([1.01, 1.01, 1.01]) connector();
        translate([abs(hole_offset - 31), 0, 0]) scale([1.01, 1.01, 1.01]) connector();
        translate([abs(hole_offset - 51), 0, 0]) scale([1.01, 1.01, 1.01]) connector();
        translate([abs(hole_offset - 71), 0, 0]) scale([1.01, 1.01, 1.01]) connector();
        translate([abs(hole_offset - 91), 0, 0]) scale([1.01, 1.01, 1.01]) connector();
        translate([abs(hole_offset - 111), 0, 0]) scale([1.01, 1.01, 1.01]) connector();
        translate([abs(hole_offset - 131), 0, 0]) scale([1.01, 1.01, 1.01]) connector();
          }
    }
  }
}

module magnet(height = 2, diameter = 6) {
  cyl(h=height, d=diameter, anchor=TOP);
}

module connector(
  prong_length = 10,
  prong_thickness = 1.5,
  peg_length = 5,
  peg_thickness = 3,
  width = 10,
) {
  cuboid([width, prong_length, prong_thickness], anchor=FRONT + BOTTOM);
  translate([0, prong_length - peg_length, prong_thickness]) cuboid([width, peg_length, peg_thickness], anchor=FRONT + TOP);
}

translate([0, 2, 0]) carrying_case_lid(magnets_top = true);
translate([0, -2, 3]) rotate([0, 180, 180]) carrying_case_lid(magnets_top = false);
