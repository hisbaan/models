module corner_spacer(width, side_length_1, side_length_2, height) {
  cube([width, side_length_1, height]);
  cube([side_length_2, width, height]);
}

corner_spacer(width = 75, side_length_1 = 26, side_length_2 = 27, height = 4);
