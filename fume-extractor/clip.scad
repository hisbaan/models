$fn = $preview ? 64 : 128;
epsilon = 0.002;

module clip(height = 6, thickness = 1.2, width = 2.4, detent_size = 1.2) {
  translate([-width / 2, -thickness / 2, 0]) {
    cube([width, thickness, height - detent_size]);
    translate([width / 2, thickness, height - detent_size]) rotate(a=[90, 0, 0]) cylinder(h=thickness, r=detent_size, center=false);
    translate([width / 2, thickness - epsilon, height - detent_size]) difference() {
      sphere(detent_size);
      translate([-detent_size, -2*detent_size, -detent_size]) cube([detent_size * 2, detent_size * 2, detent_size * 2]);
    }
  }
}

clip();

