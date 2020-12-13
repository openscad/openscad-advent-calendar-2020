$fa = 1;
$fs = 0.2;

module curve(width, height, length, dh, rect_width, extra_bend) {
    r = (pow(length/2, 2) + pow(dh, 2)) / (2 * dh) + extra_bend;
    a = 2 * asin((length/2)/r);

    translate([-(r -dh), 0, -rect_width/2])
    rotate([0, 0, -a/2])
    rotate_extrude(angle = a)
    translate([r, 0, 0])
    square(size = [height, width], center = true);
}

module base(){
    color("Gold")
    difference(){
        union(){
            cylinder(h=20,d=100);

            translate([0,0,19.5])
            rotate_extrude(convexity = 1)
            translate([50, 0, 0])
            circle(d = 1);

            translate([0,0,0])
            rotate_extrude(convexity = 10)
            translate([50, 0, 0])
            circle(d = 1);
        }

        translate([0,0,-0.01])
        cylinder(h=25,d=96);
    }
}

module spike(){
    color("Gold")
    rotate([0,0,90])
    intersection(){
        hull(){
            translate([6,0,30])
            cube([0.01,1.51,1]);

            rotate([0,0,-90])
            translate([-1.5,6,1])
            curve(1, 2, 15, 1, 1, 21);
        }

        rotate([0,0,-90])
        translate([-1.5,6,16.5])
        curve(32, 2, 15, 1, 1, 21);
    }

    color("Gold")
    translate([-1,6,30])
    sphere(3);
}

module diamond(){
    color("White")
    translate([0,0,2])
    cylinder(h=3,r=45/2);

    color("Red")
    translate([0,0,7])
    rotate(45)
    cube([30,30,4],center=true);
}

module crown(){
    base();

    for ( angle = [0 : 30 : 360] ) {
        rotate([0,0,angle])
        translate([49.5,-6,20])
        spike();

        translate([0,0,60])
        rotate([0,90,angle])
        translate([49.5,0,49.5])
        scale(0.2)
        diamond();
    }
}

crown();

// Written in 2020 by Zingos
//
// To the extent possible under law, the author(s) have dedicated all
// copyright and related and neighboring rights to this software to the
// public domain worldwide. This software is distributed without any
// warranty.
//
// You should have received a copy of the CC0 Public Domain
// Dedication along with this software.
// If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.
