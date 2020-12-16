$fa = $preview ? 2 : 5;
$fs = $preview ? 0.2 : 1;

nr = 30;
radius = 20;
twist = 180;
height = 100;
scale = 2.2;
size = 2;

module shape(nr, height, twist, scale)
    for (a = [1:nr])
        color(hsv(a/nr, 0.4))
            linear_extrude(height = height, twist = twist, scale = scale)
                rotate(360/nr * a)
                    translate([radius, 0])
                        rotate(20)
                            scale([0.4, 1])
                                circle(size);

module top(nr, height, twist, scale)
    for (a = [1:nr])
        color(hsv(a/nr, 0.6))
            rotate(360/nr * a - twist)
                translate([scale * radius, 0, height])
                    scale([0.3 * scale, 2, 0.5])
                        sphere(2 * size);

module base()
    color("Gray")
        cylinder(h = 2, r = radius);

module vase() {
    base();
    top(nr, height, twist, scale);
    translate([0, 0, 0.01]) shape(nr, height, twist, scale);
}

vase();

function doHsvMatrix(h,s,v,p,q,t,a=1)=[h<1?v:h<2?q:h<3?p:h<4?p:h<5?t:v,h<1?t:h<2?v:h<3?v:h<4?q:h<5?p:p,h<1?p:h<2?p:h<3?t:h<4?v:h<5?v:q,a];
function hsv(h,s=1,v=1,a=1)=doHsvMatrix((h%1)*6,s<0?0:s>1?1:s,v<0?0:v>1?1:v,v*(1-s),v*(1-s*((h%1)*6-floor((h%1)*6))),v*(1-s*(1-((h%1)*6-floor((h%1)*6)))),a);

// Written in 2020 by Torsten Paul <Torsten.Paul@gmx.de>
// HSV color conversion functions by Yona Appletree (Hypher)
//
// To the extent possible under law, the author(s) have dedicated all
// copyright and related and neighboring rights to this software to the
// public domain worldwide. This software is distributed without any
// warranty.
//
// You should have received a copy of the CC0 Public Domain
// Dedication along with this software.
// If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.
