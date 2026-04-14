TYPST := typst

.PHONY: all clean watch handout flattened present speaker

all: present

%-with-notes.pdf: %.typ
	$(TYPST) compile --pdf-standard a-2b --input handout=true $< $@ 

%-slides-only.pdf: %.typ
	$(TYPST) compile --pdf-standard a-2b --input speaker=false --input handout=false $< $@ 

# For printers that can't handle transparency
%-flattened.pdf: %.pdf
	gs -dNOPAUSE -dBATCH -sDEVICE=pdfimage32 -sOutputFile=$@ $<

%.pdf: %.typ
	$(TYPST) compile --input speaker=true $< $@ 

slides: rust-interviewing-slides-only.pdf
handout: rust-interviewing-with-notes.pdf
flattened: rust-interviewing-flattened.pdf

present: rust-interviewing.pdf
	pympress $<

clean:
	rm -f *.pdf