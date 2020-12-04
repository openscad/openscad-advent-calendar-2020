// https://de.wikipedia.org/wiki/Haus_vom_Nikolaus
//
// 1) Enable animation
// 2) In animation fields, set FPS = 10, Steps = 300

$fa = 4; $fs = 0.4;
segments = 16;

function tval(t, p) = let(sqt = pow(t, p)) sqt / (2 * (sqt - t) + 1);
function time(min, max, p) = $t < min
    ? undef
    : $t >= max ? 1.0 : tval(($t - min) / (max - min), p);

module cyl(x, y, a, h) {
    translate([x, y, 0]) rotate([0, 90, a]) cylinder(h * $a);
}

module anim(segment, p, col) {
    $a = time(segment / segments, (segment + 1) / segments, p);
    if (!is_undef($a))
        color(col, $a < 1.0 ? 0.3 : 1)
            children();
}

C1 = "red"; C2 = "green";
A = 20; B = 40; C = 60; D = B * sqrt(2); E = A * sqrt(2);

anim( 0, 3, C1) sphere(2 * $a);
anim( 1, 3, C1) translate([B, 0, 0]) sphere(2 * $a);
anim( 2, 3, C1) translate([B, B, 0]) sphere(2 * $a);
anim( 3, 3, C1) translate([0, B, 0]) sphere(2 * $a);
anim( 4, 3, C1) translate([A, C, 0]) sphere(2 * $a);

anim( 6, 2, C2) cyl(0, 0,   0, B);
anim( 7, 2, C2) cyl(B, 0,  90, B);
anim( 8, 2, C2) cyl(B, B, 225, D);
anim( 9, 2, C2) cyl(0, 0,  90, B);
anim(10, 2, C2) cyl(0, B,   0, B);
anim(11, 2, C2) cyl(B, B, 135, E);
anim(12, 2, C2) cyl(A, C, 225, E);
anim(13, 2, C2) cyl(0, B, 315, D);

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
