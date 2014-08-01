# Makefile para Informe PFE

LATEX = pdflatex
BIB = bibtex
GLOSSARIES = makeglossaries

## Sources
SRC = Informe.tex
PDF = $(SRC:%.tex=%.pdf)

.PHONY	: all clean

all 	: 
	$(LATEX) $(SRC)
	$(BIBTEX)<$(SRC:%.tex=%.aux)
	$(GLOSSARIES) $(SRC:%.tex=%)
	$(LATEX) $(SRC)
	$(LATEX) $(SRC)	
	
clean	:
	-rm -f $(SRC:%.tex=%.log) $(SRC:%.tex=%.lof) $(SRC:%.tex=%.glsdefs) $(SRC:%.tex=%.aux) $(SRC:%.tex=%.out)
	-rm -f $(SRC:%.tex=%.toc) $(SRC:%.tex=%.xdy) $(SRC:%.tex=%.acn) $(SRC:%.tex=%.backup) $(SRC:%.tex=%.pdf)
