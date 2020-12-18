// https://en.wikipedia.org/wiki/Barnsley_fern

// set to 0 for randomized seed values
seed = 37;
scale = 10;
count = 50000;
radius = 0.2;

s = seed > 0 ? seed : floor(rands(0, 100000, 1)[0]);
rand = rands(0, 1, count, s);

function nextx(p, r) =
    r < 0.01
        ? 0
        : r < 0.86
            ? 0.85 * p.x + 0.04 * p.y
            : r < 0.93
                ? 0.20 * p.x - 0.26 * p.y
                : -0.15 * p.x + 0.28 * p.y;

function nexty(p, r) =
    r < 0.01
        ? 0.16 * p.y
        : r < 0.86
            ? -0.04 * p.x + 0.85 * p.y + 1.6
            : r < 0.93
                ? 0.23 * p.x + 0.22 * p.y + 1.6
                : 0.26 * p.x + 0.24 * p.y + 0.44;

function next(p, r) = [
    nextx(p, r),
    nexty(p, r)
];

function points(cnt) = [
    for (i = 0, p = [0, 0];i < cnt;i = i + 1, p = next(p, rand[i])) p
];

module barnsley_fern() {
    echo(seed = s);
    %if (seed == 0)
        translate([0, -scale / 3])
            linear_extrude(0.01)
                text(str("seed = ", s), scale / 5, halign = "center");
    for (p = points(count))
        color("Green")
            translate(scale * p)
                cylinder(r = radius, h = 0.01);
}

barnsley_fern();

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
