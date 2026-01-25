include <units.scad>;
include <BOSL2/std.scad>;
use <base.scad>;
use <plate.scad>;

module fit_test() {
  base();
  translate([0, base_y, plate_wall_height + case_floor_thickness]) rotate([180, 0, 0]) housing();
}

fit_test();
