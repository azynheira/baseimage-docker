LATEX_CMD?=pdflatex -interaction=nonstopmode --shell-escape
MKIDX_CMD?=makeindex
BIBTEX_CMD?=bibtex
LATEX_COUNT?=8
MANUAL_FILE?=refman

all: $(MANUAL_FILE).pdf

pdf: $(MANUAL_FILE).pdf

$(MANUAL_FILE).pdf: clean $(MANUAL_FILE).tex
	$(LATEX_CMD) $(MANUAL_FILE)  || true
	$(MKIDX_CMD) $(MANUAL_FILE).idx
	$(LATEX_CMD) $(MANUAL_FILE)  || true
	latex_count=$(LATEX_COUNT) ; \
	while grep -E -s 'Rerun (LaTeX|to get cross-references right|to get bibliographical references right)' $(MANUAL_FILE).log && [ $$latex_count -gt 0 ] ;\
	    do \
	      echo "Rerunning latex...." ;\
	      $(LATEX_CMD) $(MANUAL_FILE)  || true ;\
	      latex_count=`expr $$latex_count - 1` ;\
	    done
	$(MKIDX_CMD) $(MANUAL_FILE).idx
	$(LATEX_CMD) $(MANUAL_FILE)  || true

fix_latex_files:
	sed -i -E "s/\\includegraphics\[(.*)\]\{(.*)\.svg\}/\\includesvg[width=300pt,height=300pt]{\2.svg}/" *.tex

clean:
	rm -f *.ps *.dvi *.aux *.toc *.idx *.ind *.ilg *.log *.out *.brf *.blg *.bbl $(MANUAL_FILE).pdf
