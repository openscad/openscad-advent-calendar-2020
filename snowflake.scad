// Cellular Automaton by Silvia Hao
// https://community.wolfram.com/groups/-/m/t/235291
// https://mathematica.stackexchange.com/questions/39361/how-to-generate-a-random-snowflake

// Number of iterations to run
cnt = 60; // [5:100]
// Select shape, set to -1 for random seed
idx = 0; // [-1:63]

module hex(r) {
    polygon([for (a = [0:60:359]) r * [sin(a), cos(a)]]);
}

module draw(r, x, y, c1, c2) {
    r1 = r * sqrt(3);
    xx = floor(x);
    yy = floor(y);
    translate([r1 * xx - yy / 2 * r1, r * 1.5 * yy]) {
        color(c1)
            linear_extrude(1, center = true)
                hex(r * 2);
        color(c2)
            linear_extrude(2, center = true)
                hex(r);
    }
}

function get(v, x, y, s) = let(m = v[0][0].x)
        (x < m || x > abs(m) || y < m || y > abs(m))
            ? false
            : v[y + s][x + s].z;

function pos(v, x, y, s) = [1,1,1,1,1,1] * [
    for (o = [0:5])
        get(v, x + offsets[o].x, y + offsets[o].y, s)
            ? pow(2, o)
            : 0
];

function nextv(set, idx, step) = let(r = rnd[step])
    set && r > melt[idx]
        ? false
        : !set && r < freeze[idx]
            ? true
            : set;

function next(v, step) = let (s = abs(v[0][0].x), r = [-s - 1:s + 1]) [
    for (y = r) [
        for (x = r)
            let (set = get(v, x, y, s), idx = classes[pos(v, x, y, s)])
                [x, y, nextv(set, idx, step)]
    ]
];

function calc(v, cnt) = cnt <= 0 ? v : calc(next(v, cnt - 1), cnt - 1);

seeds = [
     30364,  32779,  32981,  33934,  51138,  51577,  62583,
     63796, 103211, 105941, 106520, 108391, 111107, 121360,
    123470, 124385, 129754, 130198, 130971, 131363, 158059,
    188105, 193928, 194704, 195281, 237225, 263330, 271173,
    292767, 302211, 310199, 310957, 311833, 340998, 416554,
    440142, 478337, 492463, 546036, 595695, 595740, 627931,
    637804, 684901, 688271, 697840, 698219, 713914, 762162,
    772658, 788969, 805417, 806513, 807950, 809260, 809878,
    911043, 961804, 969878, 972837, 973313, 985459, 998589,
];

offsets = [[-1, 0], [-1, -1], [0, -1], [1, 0], [1, 1], [ 0, 1]];

classes = [
    0, 1, 1, 2, 1, 3,  2,  4, 1, 5, 3,  6, 2,  6,  4,  7,
    1, 3, 5, 6, 3, 8,  6,  9, 2, 6, 6, 10, 4,  9,  7, 11,
    1, 2, 3, 4, 5, 6,  6,  7, 3, 6, 8,  9, 6, 10,  9, 11,
    2, 4, 6, 7, 6, 9, 10, 11, 4, 7, 9, 11, 7, 11, 11, 12,
];

melt   = [1, 0, 0.7, 0.7, 0.4,   0,   0,   0, 0.3, 0.5,   0, 0.4, 0.1, 0];
freeze = [0, 1, 0.3, 0.2,   0, 0.3, 0.1, 0.1,   0, 0.1, 0.1, 0.9, 0.9, 0];

seed = idx < 0 ? floor(rands(1,1000000,1)[0]) : seeds[idx];

rnd = rands(0, 1, cnt, seed);
array = assert(idx < len(seeds)) calc([[[0, 0, true]]], cnt);
for (line = array)
    for (point = line)
        if (point[2])
            draw(1, point[0], point[1], "PowderBlue", "AliceBlue");

echo(seed = seed);

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
