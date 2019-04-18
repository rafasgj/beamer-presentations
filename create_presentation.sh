#!/bin/sh

[ $# -ne 2 ] && {
cat <<EOF
usage: create_presentation.sh <project> <theme>
    <project> is the name of the project and main presentation.
    <theme> is the theme to use as found on /themes/
EOF
exit
}

SRC=`dirname $(readlink -f  "$0")`

project="$1" 
shift
theme="`echo $1 | cut -d"." -f1`"
shift

mkdir "${project}"
mkdir "${project}/themes"
mkdir "${project}/images"

cp "${SRC}/themes/${theme}.tex" "${project}/themes/"
if [ -f "${SRC}/themes/${theme}.images" ]
then
    cat "${SRC}/themes/${theme}.images" | while read img 
    do
        cp "${SRC}/themes/images/${img}" "${project}/images/"
    done
fi

cp ${SRC}/presentations.tex "${project}"
cp -r ${SRC}/listings "${project}"

cat >"${project}/${project}.tex" <<EOF
\\input{presentations}

\\loadtheme{${theme}}

\\title{}
\\subtitle{}
\\author{}
\\institute{}
\\date{}

\\begin{document}

\\coverframe

\\begin{frame}
    \\frametitle{firstframe}

    \\begin{itemize}
        \\item A first level items.
        \\item Another first level items.
    \\end{itemize}
\\end{frame}

\\finalframe[Thank you!]{\url{email@example.com}}

\\end{document}

EOF

cat >"${project}/Makefile" <<EOF
PALESTRAS=${project}

%.pdf: %.tex
	xelatex \$<
	xelatex \$<
	\$(RM) *.aux *.dvi *.out *.log *.nav *.snm *.toc *.vrb

all: \$(patsubst %,%.pdf,\$(PALESTRAS))

.PHONY: all clean

clean:
	\$(RM) *.aux *.dvi *.pdf *.out *.log *.nav *.snm *.toc *.fls *.fdb_latexmk *.synctex.gz *.vrb
EOF

