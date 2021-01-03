# Makefile - create STL files from OpenSCAD source
# Andrew Ho (andrew@zeuscat.com)

ifeq ($(shell uname), Darwin)
  OPENSCAD = /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD
else
  OPENSCAD = openscad
endif

TARGETS = potbase.stl

all: $(TARGETS)

potbase.stl: potbase.scad
	$(OPENSCAD) -o potbase.stl potbase.scad

clean:
	@rm -f $(TARGETS)
