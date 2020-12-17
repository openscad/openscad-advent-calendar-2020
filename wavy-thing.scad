$fa = 2; $fs = 0.2;

r = 4;
w = 50;
h = 155;
cnt = 7;
steps = 8;
space = 12;

function weave(x) = [
    for (a = [0 : $fa / 2 : 359.99])
        (x + r * cos(a * steps)) * [ -sin(a), cos(a) ]
];

module ring() {
    rotate_extrude()
        translate([w - r - 1, 0])
            square([2 * r + 2, space / 4]);
}

module cylinders() {
    for (a = [0 : 2 * steps - 1])
        rotate(a * 360 / (2 * steps))
            translate([w, 0, 0])
                cylinder(r = r, h = h);
}

module weave() {
    difference() {
        polygon(weave(w + 1));
        polygon(weave(w - 1));
    }
}

module model() {
    cylinders();
    ring();
    translate([0, 0, h - space / 4]) ring();
    for (a = [0  : cnt - 1])
        color([1 / cnt * a, 1 - 1 / cnt * a, 0])
            translate([0, 0, a * h / cnt + space/4])
                linear_extrude(h / cnt - space / 2)
                    rotate(a * 180 / steps)
                        weave();
}

model();

// Written in 2018 by Torsten Paul <Torsten.Paul@gmx.de>
//
// To the extent possible under law, the author(s) have dedicated all
// copyright and related and neighboring rights to this software to the
// public domain worldwide. This software is distributed without any
// warranty.
//
// You should have received a copy of the CC0 Public Domain
// Dedication along with this software.
// If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.
