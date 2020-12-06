// Sixpack

$fa = 2;
$fs = 0.2;

module cap() {
    color("silver") for (k = [0:10:350]) {
        hull() {
            translate([ 0, 0, 2 ]) cylinder(.1, 10, 10);
            rotate([ 0, 0, k ]) linear_extrude(.1)
                polygon(points = [ [ 0, 0 ], [ 2, 10 ], [ 0, 12 ], [ -2, 10 ] ],
                        paths = [[ 0, 1, 2, 3, 0 ]],
                        convexity = 2);
        }
    }
}

module bottle() {
    // base
    translate([ 0, 0, 1 ]) rotate_extrude(convexity = 10) {
        translate([ 5, 0, 5 ]) circle(1);
    }
    // bottle
    color("brown")
    {
        difference() {
            translate([ 0, 0, 1 ]) cylinder(24, 6, 6);
            translate([ 0, 0, 2 ]) cylinder(31, 5, 5);
        }
        // top lip
        translate([ 0, 0, 45 ]) rotate_extrude(convexity = 5) {
            translate([ 2, 0, 0 ]) circle(.8);
        }
        // bottom of neck
        difference() {
            translate([ 0, 0, 25 ]) cylinder(10, 6, 3);
            cylinder(10, 5, 2.5);
        }
        // top of neck
        difference() {
            translate([ 0, 0, 35 ]) cylinder(10, 3, 2.5);
            translate([ 0, 0, 35 ]) cylinder(11, 2, 2);
        }
    }
    // comment out next 3 lines for open bottle
    translate([ 0, 0, 45 ]) scale([ .25, .25, .5 ]) cap();
}

module holder() {
    cube([ 39, 25, 1 ]);
    cube([ 39, 1, 25 ]);
    translate([ 0, 25, 0 ]) cube([ 39, 1, 25 ]);
    cube([ 1, 25, 25 ]);
    translate([ 38, 0, 0 ]) cube([ 1, 25, 25 ]);
    // handle
    difference() {
        translate([ 0, 13.5, 0 ]) rotate([ 90, 0, 0 ]) linear_extrude(1)
            polygon(points = [ [ 0, 0 ], [ 38, 0 ], [ 38, 35 ], [ 29, 50 ], [ 10, 50 ], [ 0, 35 ] ],
                    paths = [[ 0, 1, 2, 3, 4, 5, 0 ]],
                    convexity = 2);
        translate([ 14, 11.6, 44 ]) cube([ 10, 2, 4 ]);
        translate([ 14, 11.6, 46 ]) rotate([ -90, 0, 0 ]) cylinder(2, 2, 2);
        translate([ 23, 11.6, 46 ]) rotate([ -90, 0, 0 ]) cylinder(2, 2, 2);
    }
}

translate([ 6, 5, 0 ]) color("red") holder();

// sixpack
for (i = [1:1:2]) {
    for (k = [1:1:3]) {
        translate([ k * 12.5, i * 12.5, 1.1 ])
            bottle();
    }
}

translate([ 8, 5, 10 ]) rotate([90, 0, 0]) color("blue") text("CHEERS", font = "Liberation Sans", size = 6);

// Written in 2020 by Algot Runeman
//
// To the extent possible under law, the author(s) have dedicated all
// copyright and related and neighboring rights to this software to the
// public domain worldwide. This software is distributed without any
// warranty.
//
// You should have received a copy of the CC0 Public Domain
// Dedication along with this software.
// If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.