headDia=20;
earDia=10;

module elephantEar(dia,height){
	hull(){
		translate([0, (height-dia)/2]) circle(d=dia);
		translate([0,-(height-dia)/2]) circle(d=dia);
	}
}

module trunk(length,width){
	hull(){
		square(width,center=true);
		translate([0,-length]) circle(d=width);
		}
}

module eyes(dia,sep){
	translate([ sep,0]) circle(dia);
	translate([-sep,0]) circle(dia);
}

module headBase(){
	translate([ (headDia*0.75)/2+earDia/2,0]) elephantEar(dia=earDia,height=headDia);
	translate([-(headDia*0.75)/2-earDia/2,0]) elephantEar(dia=earDia,height=headDia);
	circle(d=headDia);
	trunk(length=headDia,width=headDia/5);
}

module withEyes(){
difference(){
	headBase();
	eyes(dia=headDia/8,sep=headDia/5);
}
}

module withEarInset(){
	difference(){
		withEyes();
		translate([ ((headDia*0.75)/2+earDia/2),0]) elephantEar(dia=earDia*.75,height=headDia*.75);
		translate([-((headDia*0.75)/2+earDia/2),0]) elephantEar(dia=earDia*.75,height=headDia*.75);
	}
}

module trunkRibs(ribDepth,RibCount,TrunkLength,headDia,width,zTop){
firstNotch=(TrunkLength-headDia/2)*1.1;
notchGap=((TrunkLength+width)-firstNotch)/(RibCount);
	for(i=[0,1,RibCount-1]){
		translate([0,-firstNotch-(notchGap*i),zTop]) rotate([0,90,0]) cylinder(r=ribDepth,h=width,center=true, $fn=15);
	}
}

module mainBlock(){
linear_extrude(height=4) withEarInset();
linear_extrude(height=3) withEyes();
linear_extrude(height=2) headBase();
}

color("gray") difference(){
	mainBlock();
	trunkRibs(0.5,3,TrunkLength=headDia,headDia=headDia,width=headDia/5,zTop=4);
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
