include <BOSL2/std.scad>;

$fn = $preview ? 64 : 256;
epsilon = 0.002;

module base(
  fan_size = 40,
  fan_thickness = 25,
  wall_thickness = 2,
  base_height = 10,
  chamfer = 0.4,
  pcb_length = 23.6,
  pcb_width = 12,
  pcb_height = 1,
  usb_height = 3,
  usb_width = 9,
) {
  difference() {
    difference() {
      difference() {
        cuboid(
          [
            fan_size + 2 * wall_thickness,
            fan_thickness + wall_thickness,
            base_height + wall_thickness
          ],
          anchor=BOTTOM,
          chamfer=chamfer
        );
        translate([0, 0, wall_thickness])
          cuboid(
            [
              fan_size,
              fan_thickness - wall_thickness,
              base_height + epsilon
            ],
            anchor=BOTTOM,
            chamfer=-chamfer,
            edges=TOP
          );
      }
      translate(
        [
          (fan_size - pcb_width) / 2,
          - (fan_thickness - pcb_length) / 2,
          wall_thickness - pcb_height
        ]
      )
        cuboid(
          [
            pcb_width,
            pcb_length,
            pcb_height + epsilon
          ],
          anchor = BOTTOM
        );
    }
    translate(
      [
        (fan_size - pcb_width) / 2,
        -fan_thickness / 2 - epsilon,
        wall_thickness
      ]
    )
    union() {
      cuboid(
        [usb_width, wall_thickness + 4 * epsilon, usb_height],
        rounding = usb_height / 4,
        anchor = BOTTOM,
        edges = "Y"
      );
      cuboid(
        [usb_width, wall_thickness + 4 * epsilon, usb_height / 2],
        anchor = BOTTOM
      );
      translate([usb_width / 2, 0, 0])
        cuboid(
          [(pcb_width - usb_width), wall_thickness + 4 * epsilon, 1],
          anchor = BOTTOM
        );
    }
  }
}

// pcb is 11 x 23 x 1 mm
module pcb_mount(length, width, thickness){}

base();
