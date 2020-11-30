#!/bin/bash

for n in $(seq 1 25)
do
	F=$(printf "%02d.png" $n)
	if [ ! -f "$F" ]
	then
		convert -size 240x240 xc:white -gravity Center -pointsize 50 -annotate 0 "$n" "$F"
	fi
done

convert $(for y in 0 1 2 3 ; do echo "($(for x in 0 1 2 3 4 5; do printf " %02d.png" $(( $x + 6 * $y + 1 )) ; done ) +append )"; done) -append advent-calendar-2020.png
