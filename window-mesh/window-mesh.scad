include <BOSL2/std.scad>;
include <BOSL2/joiners.scad>

$fn = $preview ? 64 : 256;
epsilon = 0.002;

width = 1075;
height = 254;
thickness = 6;
border_padding = 40;
bed_size = 180;

dovetail_width = border_padding / 2;
dovetail_thickness = 15;
dovetail_taper = 5;
dovetail_height = thickness;

module corner() {
  difference() {
    union() {
      cuboid([border_padding, height / 2, thickness], anchor=LEFT + FRONT + BOTTOM, chamfer=0.5, edges=[FRONT, LEFT, RIGHT]);
      cuboid([height / 2, border_padding, thickness], anchor=LEFT + FRONT + BOTTOM, chamfer=0.5, edges=[BACK, FRONT, LEFT]);

      translate([border_padding / 2, height / 2 + dovetail_thickness / 2 - epsilon, 0])
        rotate([0, 0, 180])
          dovetail(gender="male", width=dovetail_width, height=dovetail_height, thickness=dovetail_thickness, taper=dovetail_taper);
    }
    translate([height / 2 - dovetail_thickness / 2 + epsilon, border_padding / 2, 0 + epsilon])
      rotate([180, 0, 90])
        dovetail(gender="female", width=dovetail_width, height=dovetail_height, thickness=dovetail_thickness, taper=dovetail_taper);
  }
}

module edge() {
  remaining_width = abs(width - height);
  num_edges = ceil(remaining_width / 180);
  edge_size = remaining_width / num_edges;

  difference() {
    union() {
      cuboid([border_padding, edge_size, thickness], anchor=LEFT + FRONT + BOTTOM, chamfer=0.5, edges=[LEFT, RIGHT]);

      translate([border_padding / 2, edge_size + dovetail_thickness / 2 - epsilon, 0])
        rotate([0, 0, 180])
          dovetail(gender="male", width=dovetail_width, height=dovetail_height, thickness=dovetail_thickness, taper=dovetail_taper);
    }
    translate([border_padding / 2 + epsilon, dovetail_thickness / 2, 0 + epsilon])
      rotate([180, 0, 0])
        dovetail(gender="female", width=dovetail_width, height=dovetail_height, thickness=dovetail_thickness, taper=dovetail_taper);
  }
}

// corner();

// translate([height / 2 + border_padding + 5, height / 2 + border_padding + 5, 0]) rotate([0, 0, 180]) corner();

// translate([200, 0, 0]) edge();

edge();
