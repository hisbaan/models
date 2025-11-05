include <BOSL2/std.scad>;

$fn = $preview ? 64 : 256;

module frontplate(choc_version = "choc-v2", thickness = 1.2) {
  import_path = choc_version == "choc-v2" ? "./choc-v2/frontplate.dxf" : "./choc-v1/frontplate.dxf";
  linear_extrude(height = thickness) import(import_path, center = true);
}

frontplate();
