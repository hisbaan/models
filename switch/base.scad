include <BOSL2/std.scad>;
include <units.scad>;

module mcu_holder() {
  difference() {
    cuboid(
      [
        mcu_holder_x,
        mcu_holder_y,
        case_floor_thickness + mcu_thickness + 1,
      ],
      anchor=FRONT + LEFT + BOTTOM
    );
    // mcu cutout
    translate([case_wall_thickness, case_floor_thickness, case_floor_thickness + epsilon]) cuboid(
        [
          mcu_length,
          mcu_width,
          mcu_thickness + 1,
        ],
        anchor=FRONT + LEFT + BOTTOM
      );
    // usb port cutout
    translate([-epsilon, mcu_corner_to_port + case_wall_thickness, case_floor_thickness + mcu_thickness - mcu_port_offset])
      cuboid(
        [case_wall_thickness + 2 * epsilon, port_width, port_height],
        anchor=FRONT + LEFT + BOTTOM
      );
  }
}

module screw_hole() {
  translate([0, 0, case_floor_thickness / 2])
    cyl(
      h=case_floor_thickness / 2 + 2 * epsilon,
      d=screw_diameter,
      anchor=BOTTOM,
      chamfer1=-1
    );
  cyl(
    h=screw_chamfer + 2 * epsilon,
    d=screw_diameter + screw_chamfer * 2,
    anchor=BOTTOM,
  );
}

module heatset_insert_holder_outside() {
  scale([1.1, 1.1, 1.1]) cyl(h=plate_wall_height - plate_thickness, d=insert_hole_height + insert_wall_thickness, anchor=BOTTOM);
}

module base() {

  difference() {
    union() {
      cuboid(
        [base_x, base_y, case_floor_thickness],
        anchor=FRONT + LEFT + BOTTOM,
        chamfer=case_floor_thickness / 2,
        edges=[LEFT + FRONT, LEFT + BACK, RIGHT + FRONT, RIGHT + BACK]
      );

      // mcu holder
      difference() {
        translate([0, (base_y - mcu_holder_y) / 2, 0]) mcu_holder();

        // holes for heatset insert posts
        translate([0, 0, case_floor_thickness - epsilon])
          union() {
            translate([insert_corner_offset, insert_corner_offset, 0])
              heatset_insert_holder_outside();
            translate([insert_corner_offset, base_y - insert_corner_offset, 0])
              heatset_insert_holder_outside();
          }
      }
    }

    // screw holes
    translate([0, 0, -epsilon])
      union() {
        translate([insert_corner_offset, insert_corner_offset, 0])
          screw_hole();
        translate([base_x - insert_corner_offset, insert_corner_offset, 0])
          screw_hole();
        translate([insert_corner_offset, base_y - insert_corner_offset, 0])
          screw_hole();
        translate([base_x - insert_corner_offset, base_y - insert_corner_offset, 0])
          screw_hole();
      }
  }
}

// screw_hole();

base();
