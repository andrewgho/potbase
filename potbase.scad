// potbase.scad - base for small square succulent pot
// Andrew Ho (andrew@zeuscat.com)

pot_length = 61.91;    // 2 7/16" measured
pot_thickness = 7.94;  //   5/16" measured

margin = 4;            // space around pot and lip
thickness = 2;         // base thickness without edge radius
edge_radius = 3;       // apply Minkowski sphere of this radius to final shape

bottom_length = pot_length + (margin * 2);
half_length = bottom_length / 2;
lip_length = 12;
lip_angle = 60;

e = 0.1;
$fn = 45;

// Square bottom plate
module bottom() {
  translate([-half_length, -half_length])
    cube([bottom_length, bottom_length, thickness]);
}

// One full lip with two angle pieces
module lip_x() {
  translate([-half_length, half_length, 0])
    rotate(lip_angle, [1, 0, 0])
    cube([bottom_length, lip_length, thickness]);
  module corner() {
    translate([half_length, half_length, 0]) {
      hull() {
        rotate(lip_angle, [1, 0, 0])
          cube([e, lip_length, thickness]);
        rotate(-45, [0, 0, 1])
          rotate(lip_angle, [1, 0, 0])
          cube([e, lip_length, thickness]);
      }
    }
  }
  corner();
  mirror([1, 0, 0]) corner();
}

// Rotate lip_x() 90 degrees
module lip_y() {
  rotate(90, [0, 0, 1]) lip_x();
}

// Assemble all parts of the base, pre-Minkowski
module square_base() {
  union() {
    bottom();
    lip_x();
    lip_y();
    mirror([0, 1, 0]) lip_x();
    mirror([1, 0, 0]) lip_y();
  }
}

// Smooth edges with spherical transform
minkowski() {
  square_base();
  sphere(r = edge_radius);
}
