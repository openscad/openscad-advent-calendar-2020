// flower in a pot

$fa = 2;
$fs = 0.2;

module petal() {
    color("red") hull() {
        linear_extrude(1) circle(3);
        translate([ 0, 20, 0 ]) linear_extrude(0.2) circle(5);
    }
}

module leaf() {
    color("green") hull() {
        linear_extrude(1) circle(4);
        translate([ 0, 10, 0 ]) linear_extrude(0.5) circle(0.1);
    }
}

module flower_in_pot() {
    
    // flower proper
    for (k = [0:30:350]) {
        translate([ 0, 0, 2 ]) rotate([ 0, 0, k ]) petal();
        // sepals
        translate([ 0, 0, 0 ]) rotate([ 0, 0, k ]) leaf();
    }

    color("yellow") scale([ 1, 1, 0.3 ]) translate([ 0, 0, 15 ]) sphere(10);

    for (k = [1:1:3]) {
        translate([ k * 4 + 2, -k * 10 - 20, 0 ]) rotate([ 90, 90, -10 ])
            scale([ 1.2 * k, 1.2 * k, 1 ]) leaf();
    }
    for (k = [1:1:3]) {
        translate([ -k * 4 - 2, -k * 10 - 20, 0 ]) rotate([ 90, 270, 10 ])
            scale([ 1.2 * k, 1.2 * k, 1 ]) leaf();
    }
    rotate([ 90, 0, 0 ]) color("green") cylinder(70, 2, 2);

    // pot
    difference() {
        translate([ 0, -60, 0 ]) rotate([ 90, 0, 0 ]) cylinder(50, 30, 20);
        translate([ 0, -59, 0 ]) rotate([ 90, 0, 0 ]) cylinder(9, 28, 27);
    }
    difference() {
        translate([ 0, -60, 0 ]) rotate([ 90, 0, 0 ]) cylinder(10, 31, 30);
        translate([ 0, -59, 0 ]) rotate([ 90, 0, 0 ]) cylinder(10, 29, 28);
    }
}

translate([0, 0, 110])
    rotate([90, 0, 0])
        flower_in_pot();

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
