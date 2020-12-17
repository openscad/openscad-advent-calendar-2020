$fa = 4; $fs = 0.4;

cap_height = 5;
cap_thickness = 0.2;
cap_radius = 5;
num_scallops=5;

scallop_radius = cap_radius*sin(180/num_scallops);

module scallops(){
	intersection(){
		cylinder(r=cap_radius,h=scallop_radius);
		translate([0,0,scallop_radius])
			for(i = [1:num_scallops]){
				rotate([90,0,i*(360/num_scallops)])
				cylinder(r=scallop_radius,h=cap_radius+1);
			}
	}
}

module cap(){
	difference(){
		union(){
			scallops();
			translate([0,0,scallop_radius])
				cylinder(h=cap_height-scallop_radius,r=cap_radius);
		}
		cylinder(h=cap_height-cap_thickness,r=cap_radius-cap_thickness);
	}
}

bulb_rad = 15;
stem_cap_clearance = 0.5;
stem_width = 2*(cap_radius - stem_cap_clearance);
stem_height = cap_height - 1;

module basic_bulb_2d(){
	translate([0,-bulb_rad])
		circle(r=bulb_rad);
	square([stem_width,2*stem_height],center=true);
}



big = 100;
module bigsquare() {square(big,center=true);}
module biggersquare() {square(big+1,center=true);}
module negate1() {
	difference() {
		bigsquare();
		children();
	}
}
module negate2() {
	difference() {
		biggersquare();
		children();
	}
}

module swell2d(rad) {
	minkowski(){
		circle(r=rad);
		children();
	}
}

module swell3d(rad){
	minkowski(){
		sphere(r=rad,$fn=12); //gotta be careful with that $fn in 3d
		children();
	}
}

module fillet2d(rad) {
	negate2()
		swell2d(rad)
			negate1()
				swell2d(rad)
					children();
}

bulb_fillet_rad = 2;

module filleted_bulb_2d(){
	fillet2d(bulb_fillet_rad)
		basic_bulb_2d();
}

module east(){
	translate([big/2,0])
		bigsquare();
}

module north(){
	translate([0,big/2])
		bigsquare();
}

module bulb(){
	rotate_extrude(){
		intersection(){
			east();
			filleted_bulb_2d();
		}
	}
}

//wire stuff

wire_loop_rad = 2;
wire_bend_rad = 0.5;
wire_loop_thick = 0.02; //some arbitrary small number (much smaller than hangar_thickness)
wire_loop_width = 5;

module wire_stencil(){ //course outline of the hangar
	translate([0,wire_loop_rad])
		circle(r=wire_loop_rad);
	square([wire_loop_width,wire_loop_thick*2.001],center=true);
}

module filleted_wire_stencil_neg(){ //we need this both to outline the stencil, and to make the nice bends in the wire, so we'll make a module for it
	swell2d(wire_bend_rad){
		negate1(){
			swell2d(wire_bend_rad){
				wire_stencil();
			}
		}
	}
}

module wire_loop_2d(){
	intersection(){
		north();
		intersection(){
			swell2d(wire_loop_thick){
				filleted_wire_stencil_neg();
			}
			negate2(){filleted_wire_stencil_neg();}
		}
	}
}

module wire_loop_3d(){
	linear_extrude(height=wire_loop_thick,convexity=5)
		wire_loop_2d();
}

hanger_thickness = 0.5; //the actual thickness of the hanger wire

module hanger(){
	swell3d(hanger_thickness/2){
		wire_loop_3d();
	}
}

module hanger_positioned(){
	translate([0,0,cap_height])
		rotate([90,0,0])
			hanger();
}

color([1,0,0])
	bulb();
color([1,1,1])
	cap();
color([0.5,0.5,0.5])
	hanger_positioned();

// Written in 2020 by dTal
//
// To the extent possible under law, the author(s) have dedicated all
// copyright and related and neighboring rights to this software to the
// public domain worldwide. This software is distributed without any
// warranty.
//
// You should have received a copy of the CC0 Public Domain
// Dedication along with this software.
// If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.
