$fa = 4; $fs = 0.4;

n = 13;
layers = 10;

// simplified Gielis equation
function gielis(t,l,n) = l / pow(abs(cos(t/4)) + abs(sin(t/4)), 1/n);

function point(t) = [cos(t), sin(t)];

module leaf(l, n) {
    points = [ for (t = [0:5:360]) gielis(t, l, n) * point(t) ];
    linear_extrude(0.2) polygon(points);
}

module flower() {
    for (l = [0:layers])
        color((l / layers / 3 + 0.6) * [1.0, 0.3, 0.0])
            for (a = [1:n])
                rotate(a * 360/n)
                    rotate([0, -2 * l, 0])
                        translate([1, 0, 0])
                            leaf(15 - l, 0.08 - l / n / 30);

    color("gold")
        scale([1, 1, 0.5])
            sphere(2);
}

flower();

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
