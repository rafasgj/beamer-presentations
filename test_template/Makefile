PALESTRAS=test_template

%.pdf: %.tex
	pdflatex $<
	pdflatex $<
	$(RM) *.aux *.dvi *.out *.log *.nav *.snm *.toc

all: $(patsubst %,%.pdf,$(PALESTRAS))

.PHONY: all clean

clean:
	$(RM) *.aux *.dvi *.pdf *.out *.log *.nav *.snm *.toc *.fls *.fdb_latexmk *.synctex.gz
