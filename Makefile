PNGS=$(patsubst %.param,%.png,$(wildcard *.param))

_%.png : %.param .options
	openscad -o $@ `cat .options` `cat $<`
	cp `awk '{print $$NF;}' $<` $(patsubst %.param,%.scad,$<)

%.png : _%.png
	convert $< -scale 240x-1 $@

all : $(PNGS)
	bash overview.sh
	for a in $$(seq 1 24); do N=$$(printf "%02d.param" $$a); echo "$$N: $$(cat $$N 2>/dev/null)" ; done

sync :
	rsync -avP [0-2][0-9].png [0-2][0-9].scad openscad@files.openscad.org:tmp/

clean :
	rm -f [0-2][0-9].png [0-2][0-9].scad

.PHONY: sync clean
