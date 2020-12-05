PNGS=$(patsubst %.param,%.png,$(wildcard *.param))
GIFS=$(patsubst %.anim,%.gif,$(wildcard *.anim))

_%.png : %.param .options
	openscad -o $@ `cat .options` `cat $<`
	cp `awk '{print $$NF;}' $<` $(patsubst %.param,%.scad,$<)

%.png : _%.png
	convert $< -scale 240x-1 $@

%.gif : %.anim
	openscad-nightly -o _anim_.png --imgsize 1024,1024 `cat $<`
	convert -delay 8 _anim_*.png -loop 0 -resize 256x256 $@
	rm -f _anim_*.png

all : $(PNGS) $(GIFS)
	bash overview.sh
	for a in $$(seq 1 24); do N=$$(printf "%02d.param" $$a); echo "$$N: $$(cat $$N 2>/dev/null)" ; done

sync :
	rsync -avP [0-2][0-9].png [0-2][0-9].gif [0-2][0-9].scad openscad@files.openscad.org:tmp/

clean :
	rm -f [0-2][0-9].png [0-2][0-9].scad

.PHONY: sync clean
