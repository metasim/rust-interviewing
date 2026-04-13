TYPST   := typst
SRC     := rust-interviewing.typ
OUTPUT  := rust-interviewing.pdf
HANDOUT := rust-interviewing-handout.pdf

.PHONY: all clean watch handout

all: $(OUTPUT) 

$(OUTPUT): $(SRC)
	$(TYPST) compile $(SRC) $(OUTPUT)

handout: $(HANDOUT)

$(HANDOUT): $(SRC)
	$(TYPST) compile --pdf-standard a-2b --input handout=true $(SRC) $(HANDOUT)
	@echo "Handout with notes generated: $(HANDOUT)"

watch:
	$(TYPST) watch $(SRC) $(OUTPUT)

clean:
	rm -f $(OUTPUT) $(HANDOUT) $(PDFPC)


flattened-%.pdf: %.pdf
	gs -dNOPAUSE -dBATCH -sDEVICE=pdfimage24 -sOutputFile=$@ $<

flattened: flattened-$(HANDOUT)