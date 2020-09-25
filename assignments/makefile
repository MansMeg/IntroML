SOURCESMD=$(shell find . -name "assignment*.md")
SOURCESRNW=$(shell find . -name "*.Rtex")
TARGETHTML = $(SOURCESMD:%.md=%.html)
TARGETPDF = $(SOURCESRNW:%.Rnw=%.pdf)

%.pdf: %.tex
	pdflatex $<; /bin/rm assignment*.tex assignment*.aux assignment*.log assignment*.out

%.tex: %.Rtex
	Rscript -e 'Sweave("$<")'

%.html: %.md
	Rscript -e 'rmarkdown::render("$<")'

html: $(TARGETHTML)

pdf: $(TARGETPDF)

all: pdf html
