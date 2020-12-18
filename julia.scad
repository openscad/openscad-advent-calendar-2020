// https://en.wikipedia.org/wiki/Julia_set

R = 3;

set = 2;

size = 200;

max_iteration = 500;

sets = [
    [ -0.61803,  0.0000 ],
    [ -0.40000,  0.6000 ],
    [  0.28500,  0.0000 ],
    [  0.28500,  0.0100 ],
    [  0.45000,  0.1428 ],
    [ -0.70176, -0.3842 ],
    [ -0.83500, -0.2321 ],
    [ -0.80000,  0.1560 ],
    [ -0.72690,  0.1889 ],
    [  0.00000, -0.8000 ],
];

range = [-size:1:size];
scale = R / (2 * size);

function next(p) = [
    p.x * p.x - p.y * p.y + sets[set].x,
    2 * p.x * p.y + sets[set].y
];

function iter(p, i = 0) =
    norm(p) >= R || i >= max_iteration
    ? i
    : iter(next(p), i + 1);

function calc() = [
    for (y = range, x = range) iter(scale * [x, y])
];

module julia() {
    assert(set < len(sets));
    values = calc();
    mv = max(values);
    for (y = range, x = range) {
        i = values[(y + size) * (2 * size + 1) + (x + size)];
        if (i > 2 && i < max_iteration)
            let (v = i / mv / 2)
                color(hsv(v, 1 - v))
                    translate([x, y, 0])
                        cube([0.95, 0.95, v * size / 4], center = true);
    }
}

julia();

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
