TYPST   := typst
SRC     := main.typ
OUTPUT  := presentation.pdf

.PHONY: all clean watch

all: $(OUTPUT)

$(OUTPUT): $(SRC)
	$(TYPST) compile $(SRC) $(OUTPUT)

watch:
	$(TYPST) watch $(SRC) $(OUTPUT)

clean:
	rm -f $(OUTPUT)
