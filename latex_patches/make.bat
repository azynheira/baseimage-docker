@rem This is more or less replace the makefile in Windows (would recomend either a linux machine of WSL2 environment with Ubuntu 24.04)
@echo off
sed -i -E "s/\\includegraphics\[(.*)\]\{(.*)\.svg\}/\\includesvg[width=300pt,height=300pt]{\2.svg}/" *.tex
pdflatex --shell-escape refman.tex
makeindex refman.idx
pdflatex --shell-escape refman.tex
pdflatex --shell-escape refman.tex
pdflatex --shell-escape refman.tex
