// snow shovel

$fa=2; $fs=0.2; // smooth the handle

// shovel blade
color("silver")
difference(){
    translate([-10,-10,0])
        cube([20,10,2]);
    translate([-9.5,-12,.5])
        cube([19,10,2]);
    // slant
    rotate([10,0,0])
        translate([-11,-10,2])
            cube([22,10,2]);
    // scoop
    translate([-9.5,-2,2.5])
        rotate([0,90,0])
            cylinder(19,2,2);
}

// handle shaft
color("brown")
rotate([270,0,0])
translate([0,-1,0])
cylinder(30,1,1);

// handle grip
color("green")
difference(){
    hull(){
        translate([-1,31,0])
            cylinder(2,1,1);
        translate([1,31,0])
            cylinder(2,1,1);
        translate([-2,34,0])
            cylinder(2,1,1);
        translate([2,34,0])
            cylinder(2,1,1);
    }
    hull(){
        translate([-.3,31.5,-.05])
            cylinder(2.1,1,1);
        translate([.3,31.5,0])
            cylinder(2.1,1,1);
        translate([-1.3,33.5,0])
            cylinder(2.1,1,1);
        translate([1.3,33.5,0])
            cylinder(2.1,1,1);
    }
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
