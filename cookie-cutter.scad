$fa = 5; $fs = .4;

size = 35;
height = 12;

// https://mathworld.wolfram.com/HeartCurve.html
function heart(t) = 0.06 * [
	16 * pow(sin(t), 3),
	13 * cos(t) - 5 * cos(2 * t) - 2 * cos(3 * t) - cos(4 * t)
];

module heart(w = 30) {
    polygon([for (t = [0:2:360]) w * heart(t)]);
}

module outline(o) {
    difference() {
        offset(o/2) children();
        offset(-o/2) children();
    }
}

module cut(height, base_height, r1, r2) {
    translate([0, 0, -base_height])
        cylinder(r = 2 * r1, h = base_height);
    translate([0, 0, -0.01])
        cylinder(r1 = r1, r2 = r2, h = height);
}

module cookie_cutter(height = 12, d1 = 0.4, d2 = 4, base_height = 1) {
    linear_extrude(base_height)
        outline(d2)
            children();
    linear_extrude(height)
        outline(d1)
            children();
}

color("Crimson")
    cookie_cutter(height)
        heart(size);

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
