// 1) Enable animation
// 2) In animation fields, set FPS = 10, Steps = 400

nr = 5;
stars = 3;
seed = 35;

r = rands(1, 5, stars, seed);
function t(a) = a * 180 / nr;

module shape(size) {
    points = [
        for (a = [0:2 * nr - 1]) (size - size/1.5 * (a % 2)) * [-sin(t(a)), cos(t(a))]
    ];

    polygon(points);
}

echo(r);
for (a = [0:stars-1]) {
    color(a % 2 ? "Silver" : "Gold") {
        translate([0, 0, 250]) {
            rotate([90, 0, 360 * floor(r[a]) * $t]) {
                linear_extrude(10, center = true) {
                    difference() {
                        shape(10 + 100 * a + 60);
                        shape(10 + 100 * a);
                    }
                }
            }
        }
    }
}
color("White") {
    cylinder(h = 500, r = 3);
    cylinder(r = 100, h = 3);
}

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
