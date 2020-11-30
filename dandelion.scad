module flakeArm(scale=1,lclSpread=[-60:30:60]){
    for (i=lclSpread) rotate(i) translate([0,-2.5*scale]) square([50*scale,2*scale]);
}

module Projection3D(rotation=[0,0,0],sliceAngle=45){
    spread = [-70:35:70];
    rotate(rotation) rotate_extrude(angle=sliceAngle*0.1){
        translate([2.4,0]){
            flakeArm(lclSpread=spread);
            for (i=spread) rotate(i) translate([45,0]) flakeArm(0.8,[-30:30:30]);
        }
    }
}
step = 15;
module SpikeyBall() {
  for (rotation=[0:step*2:360]) Projection3D(rotation,step);
}

module Top() {
  SpikeyBall();
  rotate([90, 0, 0]) SpikeyBall();
  rotate([0, 90, 0]) SpikeyBall();
}

color("white") translate([0, 0, 200]) Top();
color("green") cylinder(h=200, d=6, $fa=1, $fs=0.4);

// Written in 2020 by Scopeuk
//
// To the extent possible under law, the author(s) have dedicated all
// copyright and related and neighboring rights to this software to the
// public domain worldwide. This software is distributed without any
// warranty.
//
// You should have received a copy of the CC0 Public Domain
// Dedication along with this software.
// If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

