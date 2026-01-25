$fn = $preview ? 64 : 256;
epsilon = 0.002;

switch_x = 14;
switch_y = 14;

choc_x = 17;
choc_y = 18;

switch_gap_x = choc_x - switch_x;
switch_gap_y = choc_y - switch_y;

outer_plate_padding = 6;

mcu_thickness = 1;
mcu_width = 18.1;
mcu_length = 23.1;
mcu_port_offset = 0.5;

mcu_holder_backstop_height = 0.75;
mcu_holder_backstop_radius = 2;

port_width = 9.1;
port_height = 3.1;
mcu_corner_to_port = 4.55;

insert_hole_diameter = 2.9;
insert_hole_height = 5;
insert_wall_thickness = 1;
insert_chamfer = insert_wall_thickness / 2;
insert_corner_offset = insert_wall_thickness + insert_hole_diameter - insert_wall_thickness + 0.1;
screw_diameter = 2.1;
screw_chamfer = 1;

plate_thickness = 1.2;

plate_wall_height = 12;
plate_wall_thickness = 2;

case_floor_thickness = 2;
case_wall_thickness = 2;

// compositions
base_x = 3 * switch_x + 3 * switch_gap_x + 2 * outer_plate_padding;
base_y = switch_y + switch_gap_y + 2 * outer_plate_padding;

mcu_holder_x=mcu_length + 2 * case_wall_thickness;
mcu_holder_y = mcu_width + 2 * case_wall_thickness;
