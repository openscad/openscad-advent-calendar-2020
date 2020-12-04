// dollhouse lamp v02
$fa = 2; $fs = 0.2;

module lamp() {
    color("aquamarine", 0.8)
    difference(){
        cylinder(20,12,15); // inverted shade
        translate([0,0,-.1])
            cylinder(21,11,14);
    }

    color("silver") {
        cylinder(50,2,2);
        translate([0,0,49.9])
            cylinder(3,6,7);
    }

    color("white")
    for(k=[0:120:360]){
        translate([0,0,.5])
            rotate([90,0,k])
                cylinder(12,.5,.5);
    }
}

if ($preview) {
    // presentation mode
    translate([20, 15, 53]) rotate([180, 0, 0]) lamp();
} else {
    // upside down for easier printing
    lamp();
}

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
