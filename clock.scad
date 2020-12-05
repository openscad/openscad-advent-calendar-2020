$fa = 4; $fs = 0.4;

function drop(t, m, a, b) = [ a * cos(t), b * (sin(t)*pow(sin(t/2), m)) ];

module num(n) {
    text(str(n), 3, halign="center", valign="center");
}

module outline(o) {
    difference() {
        children();
        offset(-o) children();
    }
}

module hand2d(scale) {
    offset(0.1) {
        circle(0.8);
        hull() {
            circle(0.3);
            translate([scale * 14, 0]) circle(0.01);
        }
    }

    translate([scale * 10, 0])
        polygon([for (t = [0:5:360]) drop(t, 4 / scale, 2.5, 2)]);
}

module hand(col, scale) {
    color(col)
        linear_extrude(0.1)
            hand2d(scale);
    color("black")
        linear_extrude(0.2)
            outline(0.1)
                hand2d(scale);
}

color("Peru")
    rotate_extrude()
        translate([20, 0])
            circle(2);

color("Wheat")
    scale([1,1,0.1])
        sphere(20);

color("DarkSlateGray")
for (a = [1:12])
   rotate(-a * 30 + 90)
        translate([15, 0])
            rotate([0,5,0])
                linear_extrude(1.7)
                    rotate(-90)
                        num(a);

color("black")
    for (a = [0:59])
        let (b = a % 5 == 0 ? 1 : 0)
            rotate(6 * a)
                translate([17.4 - b * 0.4, 0, 1])
                    rotate([0,10,0])
                        linear_extrude(0.1)
                            square([0.4 + b * 0.6, 0.1 + b * 0.1]);

color("silver")
    cylinder(r = 0.2, h = 2.5);

translate([0, 0, 2.0])
    rotate(90 - $t * 12 * 360)
        hand("Coral", 1);

translate([0, 0, 2.2])
    rotate(90 - $t * 360)
        hand("MediumAquamarine", 0.7);

// Written in 2020 by Torsten Paul <Torsten.Paul@gmx.de>
//
// To the extent possible under law, the author(s) have dedicated all
// copyright and related and neighboring rights to this software to the
// public domain worldwide. This software is distributed without any
// warranty.
//
// You should have received a copy of the CC0 Public Domain
// Dedication along with this software.
// If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.
