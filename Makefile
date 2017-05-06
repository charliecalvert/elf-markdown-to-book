CHAPTERS = $(sort $(wildcard chapters/*.md))

# echo $(CHAPTERS)

BOOKNAME=MobileApplications

EPUB_FILE = build/$(BOOKNAME).epub
MOBI_FILE = build/book.mobi
PDF_FILE = build/book.pdf


.PHONY: all
all: $(EPUB_FILE) $(MOBI_FILE) $(PDF_FILE)

.PHONY: clean
clean:
	rm -f build/*

.PHONY: epub
epub: $(EPUB_FILE)

.PHONY: mobi
mobi: $(MOBI_FILE)

.PHONY: pdf
pdf: $(PDF_FILE)


.PHONY: preview
preview: $(MOBI_FILE)
	ebook-viewer $(MOBI_FILE)


$(EPUB_FILE): clean $(CHAPTERS) meta/title.txt meta/cover.png meta/stylesheet.css meta/metadata.xml
	pandoc \
		-o $(EPUB_FILE) \
		$(CHAPTERS) \
		--epub-cover-image=meta/cover.png \
		--epub-stylesheet=meta/stylesheet.css \
		--epub-metadata=meta/metadata.xml \
		--table-of-contents

$(PDF_FILE): $(CHAPTERS) meta/title.txt
	pandoc \
		-o $(PDF_FILE) \
		meta/title.txt \
		$(CHAPTERS) \
		--toc


$(MOBI_FILE): $(EPUB_FILE)
	kindlegen $(EPUB_FILE)
