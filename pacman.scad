$fa = 4; $fs = 0.4;

function ghost1(x) = [x, 6 * pow(-x * x + 100, 0.25) - 8];
function ghost2(x) = [x, -2 * cos(1/4*x * 180) - 8];

ghostp = [
    for (x = [-10:0.1:10]) ghost1(x),
    for (x = [10:-0.1:-10]) ghost2(x)
];

ghost = [
    [ "red", 20 ],
    [ "blue", 50 ],
    [ "orange", 80 ],
    [ "magenta", 110 ]
];

module eye() {
    color("white")
        scale([0.7, 1, 0.1])
            sphere(4);
    color("black")
        translate([-0.7, 0, 0])
            scale([0.6, 0.9, 0.2])
                sphere(3);
}

module ghost(c) {
    color(c)
        linear_extrude(5)
            polygon(ghostp);
    translate([-5, 4, 5])
        eye();
    translate([+2, 4, 5])
        eye();
}

color("gold")
    translate([-20, 0, 0])
        rotate(30)
            rotate_extrude(angle = 300)
                square([10, 5]);

for (g = ghost)
    translate([g[1], 0, 0])
        ghost(g[0]);

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
