CHAPTERS = $(sort $(wildcard chapters/*.md))

# echo $(CHAPTERS)

# ERRORS AND GOTCHAs
# ==========================
# If you get: ! LaTeX Error: Command \textquotesingle unavailable in encoding T1.
# Then try: sudo apt-get install texlive-latex-extra
# ==========================
# Some Unicode characters would not render until I
# included this in the command to create a PDF:
#  --latex-engine=xelatex
# And also installed this:
#  sudo apt-get install texlive-xetex
# ==========================

BOOKNAME=MobileApplications
BOOK_PROG272_NAME=ElvenMobileDevelopment
BOOK_GIT_NAME=ElvenGit
BOOK_JS_NAME=ElvenJavaScript

EPUB_FILE = build/$(BOOKNAME).epub
EPUB_PROG272_FILE = build/$(BOOK_PROG272_NAME).epub
EPUB_GIT_FILE = build/$(BOOK_GIT_NAME).epub
EPUB_JS_FILE = build/$(BOOK_JS_NAME).epub
MOBI_FILE = build/book.mobi
PDF_FILE = build/book.pdf


.PHONY: all
all: $(EPUB_FILE) $(MOBI_FILE) $(PDF_FILE)

.PHONY: clean
clean:
	rm -f build/*

.PHONY: epub
epub: $(EPUB_FILE)

.PHONY: epub_prog272
epub_prog272: $(EPUB_PROG272_FILE)

.PHONY: epub_git
epub_git: $(EPUB_GIT_FILE)

.PHONY: epub_js
epub_js: $(EPUB_JS_FILE)

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

$(EPUB_PROG272_FILE): clean $(CHAPTERS) meta/title-prog272.txt meta/cover-prog272.png meta/stylesheet.css meta/metadata-prog272.xml
	pandoc \
		-o $(EPUB_PROG272_FILE) \
		$(CHAPTERS) \
		--epub-cover-image=meta/cover-prog272.png \
		--epub-stylesheet=meta/stylesheet.css \
		--epub-metadata=meta/metadata-prog272.xml \
		--table-of-contents

# $(EPUB_GIT_FILE): clean $(CHAPTERS) meta/title-git-book.txt meta/cover-git-book.png meta/stylesheet.css meta/metadata-git-book.xml
$(EPUB_GIT_FILE): clean $(CHAPTERS)
	pandoc \
		-o $(EPUB_GIT_FILE) \
		$(CHAPTERS) \
		--epub-cover-image=meta/cover-git-book.png \
		--epub-stylesheet=meta/stylesheet.css \
		--epub-metadata=meta/metadata-git-book.xml \
		--table-of-contents

$(EPUB_JS_FILE): clean $(CHAPTERS)
	pandoc \
		-o $(EPUB_JS_FILE) \
		$(CHAPTERS) \
		--epub-cover-image=meta/cover-js-book.png \
		--epub-stylesheet=meta/stylesheet.css \
		--epub-metadata=meta/metadata-js-book.xml \
		--table-of-contents

$(PDF_FILE): $(CHAPTERS)
	pandoc --latex-engine=xelatex \
		-o $(PDF_FILE) \
		meta/title.txt \
		meta/copyright.txt \
		$(CHAPTERS) \
		--toc


$(MOBI_FILE): $(EPUB_FILE)
	kindlegen $(EPUB_FILE)
