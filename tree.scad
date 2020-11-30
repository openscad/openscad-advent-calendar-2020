$fa = 4; $fs = 0.4;

color("green")
  for (a = [0:10])
    translate([0, 0, 10 + pow(a, 1.3)])
      rotate_extrude()
        translate([pow((12 - a) / 3.0, 1.6), 0])
          scale([0.6, 1])
            circle(pow((12 - a) / 4.0, 0.3));

color("brown")
  cylinder(r1 = 2, r2 = 0.3, h = 30);
  
// Written in 2020 by Torsten Paul <Torsten.Paul@gmx.de>
//
// To the extent possible under law, the author(s) have dedicated all
// copyright and related and neighboring rights to this software to the
// public domain worldwide. This software is distributed without any
// warranty.
//
// You should have received a copy of the CC0 Public Domain
// Dedication along with this software.
// If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.