// OpenSCAD Painting Animation
//
// Animate with FPS: 25, Steps: 250

$fa = 1;
$fs = 0.4;

jumprotstart = -360*0.5/0.5-1.1;
facerad = 25;
smilemax = 130;
jumprotend = -smilemax*(0.8-0.8)/0.2-1.1+180+smilemax/2;
smilerad = 13;
smilepos = 16;
eyepos1 = [-8, 10];
eyepos2 = [8, 10];
jump_height = 15;
paint_color = "yellow";

function faceang() = 360*$t/0.5;
function smileang() = smilemax*($t-0.8)/0.2;

module BasePlate() {
  color("white")
    translate([-30, -30, -1])
    cube([60, 60, 1.001]);
}


module Brush() {
  translate([0, 0, -0.5]) 
  rotate([0, 25, -30]) {
    color("brown")
      translate([0, 0, 14])
      scale([0.1, 0.1, 1])
      sphere(10);
    color(paint_color)
      for (r=[0.1:0.1:1])
        for (a=[0:360/(27*r):359.999])
          rotate([0, 0, a+853*r])
            translate([r, 0, 0])
            rotate([0, -0.6*atan(r/4), 0])
            cube([0.03, 0.03, 6]);
  }
}


module Jump(fract, startpos, endpos, startrot, endrot) {
  height = jump_height*(1-4*pow(fract-0.5, 2));
  locxy = fract*(endpos - startpos) + startpos;
  loc = [locxy[0], locxy[1], height];
  rot = fract*(endrot - startrot) + startrot;
  translate(loc) rotate(rot) children();
}


module BrushAnimation() {
  if ($t < 0.5) {
    rotate([0, 0, -faceang()-1.1])
    translate([0, facerad+1, 0])
    Brush();
  }
  else if ($t < 0.6) {
    midjumprot = (jumprotend - jumprotstart)/3 + jumprotstart;
    Jump(($t-0.5)/0.1, [0, facerad], eyepos1, jumprotstart, midjumprot) Brush();
  }
  else if ($t < 0.7) {
    lastjumprot = (jumprotend - jumprotstart)/3 + jumprotstart;
    midjumprot = (jumprotend - jumprotstart)*2/3 + jumprotstart;
    Jump(($t-0.6)/0.1, eyepos1, eyepos2, lastjumprot, midjumprot) Brush();
  }
  else if ($t < 0.8) {
    lastjumprot = (jumprotend - jumprotstart)*2/3 + jumprotstart;
    smang = -smileang()-1.1+180+smilemax/2;
    endspot = (smilerad+1)*[-sin(smang), cos(smang)] + [0, smilerad-smilepos];
    Jump(($t-0.7)/0.1, eyepos2, endspot, lastjumprot, jumprotend) Brush();
  }
  else {
    translate([0, smilerad-smilepos, 0])
    rotate([0, 0, -smileang()-1.1+180+smilemax/2])
    translate([0, smilerad+1, 0])
    Brush();
  }
}


module PaintAnimation() {
  color(paint_color) {
    mirror([1, 0, 0])
      rotate([0, 0, 90])
      rotate_extrude(angle=faceang()+3)
      translate([facerad, 0])
      square([2, 0.005]);

    if ($t >= 0.6) {
      linear_extrude(0.005)
      translate(eyepos1)
      circle(2);
    }

    if ($t >= 0.7) {
      linear_extrude(0.005)
      translate(eyepos2)
      circle(2);
    }

    if ($t >= 0.8) {
      mirror([1, 0, 0])
      translate([0, smilerad-smilepos, 0])
      rotate([0, 0, -90-smilemax/2])
      rotate_extrude(angle=smileang()+3)
      translate([smilerad, 0])
      square([2, 0.005]);
    }
  }
}


BasePlate();
BrushAnimation();
PaintAnimation();


// Written in 2020 by Ryan A. Colyer
//
// To the extent possible under law, the author(s) have dedicated all
// copyright and related and neighboring rights to this software to the
// public domain worldwide. This software is distributed without any
// warranty.
//
// You should have received a copy of the CC0 Public Domain
// Dedication along with this software.
// If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

