include <BOSL2/std.scad>;
include <units.scad>;

module housing() {
  difference() {
    cuboid([base_x, base_y, plate_wall_height], anchor=FRONT + LEFT + BOTTOM, chamfer=plate_wall_thickness / 2, edges=[BOTTOM, LEFT + FRONT, LEFT + BACK, RIGHT + FRONT, RIGHT + BACK]);

    translate([plate_wall_thickness, plate_wall_thickness, plate_thickness - epsilon])
      cuboid(
        [base_x - 2 * plate_wall_thickness, base_y - 2 * plate_wall_thickness, plate_wall_height - plate_thickness + 2 * epsilon],
        anchor=FRONT + LEFT + BOTTOM
      );

    translate([outer_plate_padding, outer_plate_padding, -epsilon]) union() {
        translate([switch_gap_x / 2, switch_gap_y / 2, 0])
          cuboid([switch_x, switch_y, plate_thickness + 2 * epsilon], anchor=FRONT + LEFT + BOTTOM);
        translate([switch_x + 3/2 * switch_gap_x, switch_gap_y / 2, 0])
          cuboid([switch_x, switch_y, plate_thickness + 2 * epsilon], anchor=FRONT + LEFT + BOTTOM);
        translate([2 * switch_x + switch_gap_x * 5 / 2, switch_gap_y / 2, 0])
          cuboid([switch_x, switch_y, plate_thickness + 2 * epsilon], anchor=FRONT + LEFT + BOTTOM);
      }

    // heatset insert post cutouts from main shape
    translate([0, 0, plate_wall_height + epsilon])
      union() {
        translate([insert_corner_offset, insert_corner_offset, 0])
          heatset_insert_holder_outside();
        translate([base_x - insert_corner_offset, insert_corner_offset, 0])
          heatset_insert_holder_outside();
        translate([insert_corner_offset, base_y - insert_corner_offset, 0])
          heatset_insert_holder_outside();
        translate([base_x - insert_corner_offset, base_y - insert_corner_offset, 0])
          heatset_insert_holder_outside();
      }

    translate([-epsilon, (base_y - mcu_holder_y) / 2, plate_wall_height + case_floor_thickness + epsilon])
    union() {
    cuboid(
      [
        mcu_holder_x,
        mcu_holder_y,
        case_floor_thickness + mcu_thickness + 1,
      ],
      anchor=FRONT + LEFT + TOP
    );
    translate([-epsilon, mcu_holder_y - port_width - mcu_corner_to_port - case_wall_thickness, epsilon - (case_floor_thickness+mcu_thickness + 1)])
      cuboid(
        [case_wall_thickness + 4 * epsilon, port_width, port_height - mcu_port_offset - mcu_thickness],
        anchor=FRONT + LEFT + TOP
      );
    }
  }

  // heatset insert posts
  translate([0, 0, plate_wall_height])
    union() {
      translate([insert_corner_offset, insert_corner_offset, 0])
        heatset_insert_holder();
      translate([base_x - insert_corner_offset, insert_corner_offset, 0])
        heatset_insert_holder();
      translate([insert_corner_offset, base_y - insert_corner_offset, 0])
        heatset_insert_holder();
      translate([base_x - insert_corner_offset, base_y - insert_corner_offset, 0])
        heatset_insert_holder();
    }
}

module heatset_insert_holder() {
  difference() {
    heatset_insert_holder_outside();
    translate([0, 0, epsilon]) cyl(h=plate_wall_height - plate_thickness + 2 * epsilon, d=insert_hole_diameter, anchor=TOP, chamfer2=-insert_chamfer);
  }
}

module heatset_insert_holder_outside() {
  cyl(h=plate_wall_height - plate_thickness, d=insert_hole_height + insert_wall_thickness, anchor=TOP);
}

housing();
