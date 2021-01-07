// potbase.scad - base for small square succulent pot
// Andrew Ho (andrew@zeuscat.com)

pot_length = 61.91;    // 2 7/16" measured
pot_thickness = 7.94;  //   5/16" measured

margin = 1;            // space around pot and lip
thickness = 1;         // base thickness without edge radius
radius = 3;            // round base with sphere of this radius
height = 6;            // overwall base height, including base and lip

e = 0.1;
e2 = e * 2;
$fn = 30;

inner_length = pot_length + (2 * margin);
outer_length = inner_length + (2 * thickness);
inner_height = height - thickness;

// Cube with a spherically rounded base
module rounded_bottom_cube(len, height, radius) {
  // Repeat children for each of four corners
  module foreach_corner(len) {
    translate([ len / 2,  len / 2, 0]) children();
    translate([-len / 2,  len / 2, 0]) children();
    translate([-len / 2, -len / 2, 0]) children();
    translate([ len / 2, -len / 2, 0]) children();
  }
  difference() {
    hull() {
      sphere_offset = len - (2 * radius);
      translate([0, 0, radius]) foreach_corner(sphere_offset) sphere(r = radius);
      translate([0, 0, height]) foreach_corner(sphere_offset) sphere(r = radius);
    }
    cutoff_length = len + e2;
    cutoff_offset = cutoff_length / 2;
    translate([-cutoff_offset, -cutoff_offset, height])
      cube([cutoff_length, cutoff_length, radius + e]);
  }
}

difference() {
  rounded_bottom_cube(outer_length, height, radius);
  translate([0, 0, thickness]) rounded_bottom_cube(inner_length, height, radius);
}

