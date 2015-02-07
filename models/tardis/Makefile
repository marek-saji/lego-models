NAME := tardis
MAIN_LDR := 99-tardis.ldr
PDFS := $(patsubst %.ldr,%.pdf,$(wildcard *.ldr))

all: README.md

README-meta-custom:
	printf -- 'mecabricksId: 3X8jO5R9aYJ\n' >> README.md

README-intro:
	printf -- '![Outside it looks like a Police Box.](tardis.png)\n\n' >> README.md
	printf -- '![… but it is bigger on the inside](tardis-open.png)\n\n' >> README.md

include ../build.mk
