# This file is included by individual Makefiles for each model

MAIN_LDR ?= $(NAME).ldr

README.md: README-clear README-meta README-meta-instruction-pdf README-meta-custom README-meta-end README-intro README-steps

README-clear:
	: > README.md

README-meta:
	echo $(MAIN_LDR)
	printf -- '---\n' >> README.md
	
	printf -- 'ldrName: ' >> README.md
	basename $$PWD >> README.md
	
	printf -- 'title: ' >> README.md
	perl -pe 's/\r?\n|\r/\n/g' $(MAIN_LDR) | head -n1 | cut -d' ' -f2- >> README.md
	
	printf -- 'tags: [' >> README.md
	perl -pe 's/\r?\n|\r/\n/g' $(MAIN_LDR) | grep '^0 !KEYWORDS ' | cut -d' ' -f3- | xargs printf " %s" >> README.md
	printf -- ' ]\n' >> README.md
	
	printf -- 'author: ' >> README.md
	perl -pe 's/\r?\n|\r/\n/g' $(MAIN_LDR) | grep '^0 Author: ' | cut -d' ' -f3- >> README.md
	
	printf -- 'date: ' >> README.md
	perl -pe 's/\r?\n|\r/\n/g' $(MAIN_LDR) | grep '^0 !HISTORY ' | head -n1 | cut -d' ' -f3 >> README.md
	
	printf -- 'history:\n' >> README.md
	perl -pe 's/\r?\n|\r/\n/g' $(MAIN_LDR) | grep '^0 !HISTORY ' | cut -d' ' -f3- | awk '{ printf "  - \"" $$0 "\"\n"; }' >> README.md
	
	printf -- 'license: ' >> README.md
	perl -pe 's/\r?\n|\r/\n/g' $(MAIN_LDR) | grep '^0 !LICENSE ' | cut -d' ' -f4- >> README.md


ifeq ("$(wildcard instruction-images)", "")
README-meta-instruction-pdf:
else
README-meta-instruction-pdf:
	printf -- 'instructionsPdfUrl: "$(NAME).pdf"\n' >> README.md
endif

README-meta-end:
	printf -- 'layout: model\n' >> README.md
	printf -- '---\n\n' >> README.md

ifeq ("$(wildcard instruction-images)", "")
README-steps:
else
README-steps: instruction-images
	printf -- 'Instructions\n------------\n\n' >> README.md
	ls -v instruction-images/step*.* | awk '{ print "1. ![" $$0 "](" $$0 ")\n"; }' >> README.md
	printf -- '\n' >> README.md
endif

instruction-images: $(NAME).pdf
	rm -v instruction-images/* || :
	pdftohtml -noframes $(NAME).pdf instruction-images/step
	rm instruction-images/step.html
	jpegoptim --totals --strip-all --all-progressive instruction-images/*.jpg
	trimage -f instruction-images/*.png

$(NAME).pdf: $(PDFS)
	pdfunite *-*.pdf $(NAME).pdf

%.pdf: %.ps
	ps2pdf $< > $@

%.ps: %.ldr
	@echo "Open up MLCad and print instructions to $@"
	false
