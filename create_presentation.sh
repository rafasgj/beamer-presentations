#!/bin/sh

[ $# -ne 2 ] && {
cat <<EOF
usage: create_presentation.sh <project> <theme>
    <project> is the name of the project and main presentation.
    <theme> is the theme to use as found on /themes/
EOF
exit
}

project="$1" 
shift
theme="`echo $1 | cut -d"." -f1`"
shift

mkdir "${project}"
mkdir "${project}/themes"
mkdir "${project}/images"

cp "themes/${theme}.tex" "${project}/themes/"
cat "themes/${theme}.images" | while read img 
do
    cp "images/${img}" "${project}/images/"
done

cp presentations.tex "${project}"

cat >"${project}/${project}.tex" <<EOF
\\input{presentations}

\\loadtheme{${theme}}

\\title{}
\\author{}
\\institute{}
\\date{}

\\begin{document}

\\coverframe

\\begin{frame}
    \\frametitle{firstframe}
\\end{frame}

\\finalframe{}

\\end{document}

EOF

cat >"${project}/Makefile" <<EOF
PALESTRAS=${project}

%.pdf: %.tex
	pdflatex \$<
	pdflatex \$<
	\$(RM) *.aux *.dvi *.out *.log *.nav *.snm *.toc

all: \$(patsubst %,%.pdf,\$(PALESTRAS))

.PHONY: all clean

clean:
	\$(RM) *.aux *.dvi *.pdf *.out *.log *.nav *.snm *.toc *.fls *.fdb_latexmk *.synctex.gz
EOF
