NAME := skipper
PDFS := $(patsubst %.ldr,%.pdf,$(wildcard *.ldr))

all: README.md

README-meta-custom:
	printf -- 'mecabricksId: 907vNL702Am\n' >> README.md

README-intro:
	printf '![Smile and wave boys, smile and wave](skipper.png)\n\n' >> README.md


include ../build.mk
