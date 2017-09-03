PALESTRAS=python_intro

%.pdf: %.tex
	pdflatex $<
	pdflatex $<
	$(RM) *.aux *.dvi *.out *.log *.nav *.snm *.toc *.vrb

all: $(patsubst %,%.pdf,$(PALESTRAS))

.PHONY: all clean

clean:
	$(RM) *.aux *.dvi *.pdf *.out *.log *.nav *.snm *.toc
