module equilateralTriangle(h,w){
	polygon([[-h/2,-w/2],[h/2,0],[-h/2,w/2]]);
}

baseDim = 20;

module foxHeadAbstract(){
	translate([0,-baseDim/2,0]) equilateralTriangle(h=-baseDim,w=baseDim/2);
	translate([0,baseDim/2,0]) equilateralTriangle(h=-baseDim,w=baseDim/2);
	translate([baseDim/2,0,0]) equilateralTriangle(h=baseDim*1.5,w=baseDim);
}
	
module withEyes(){
	difference(){
		foxHeadAbstract();
		translate([baseDim/10,-baseDim/3.3,0]) equilateralTriangle(h=baseDim/5,w=baseDim/5);
		translate([baseDim/10, baseDim/3.3,0]) equilateralTriangle(h=baseDim/5,w=baseDim/5);
	}
}

color("darkred") rotate(-90){
    linear_extrude(height=2) foxHeadAbstract();
    linear_extrude(height=4) withEyes();
}

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
