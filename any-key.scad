// Keycap - Any

$fa=4; $fs=0.4;

ht=10;
difference(){
    hull(){
        translate([-ht/2,-ht/2,0])
            cylinder(ht,ht/2,ht*.4);
        translate([ht/2,-ht/2,0])
            cylinder(ht,ht/2,ht*.4);
        translate([-ht/2,ht/2,0])
            cylinder(ht,ht/2,ht*.4);
        translate([ht/2,ht/2,0])
            cylinder(ht,ht/2,ht*.4);
    }
    translate([0,0,ht*1.1])
        scale([1,1,.2])
            sphere(ht);

    // attachment
    // cross version
    cube([1.5,5,5],center=true);
    cube([5,1.5,5],center=true);
}

translate([0,0,ht*.9])
color("blue"){
    linear_extrude(ht*.1)

    text("ANY", font="Liberation Sans",size=ht/2,halign="center",valign="center");
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
