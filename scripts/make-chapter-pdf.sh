#!/bin/bash

set -x

FILE="$1"
TITLE="$2"

SCRIPT_DIR=$(dirname "$0")
LA_DIR=$(dirname "$FILE")
EN_DIR=$LA_DIR/english
TMP_DIR=$SCRIPT_DIR/.tmp

rm -rfv $TMP_DIR
mkdir -v $TMP_DIR

NUM=$(basename --suffix=".txt" "$FILE")
echo $TMP_DIR/$NUM

F_TMP="$TMP_DIR"/"$NUM".tmp
F_EN="$EN_DIR"/"$NUM".txt
F_EN_TMP="$TMP_DIR"/"$NUM"EN.tmp

VERSE=1
fin=$FILE
while read -r LINE; do
#echo "\\filbreak\\noindent\\textsuperscript{$VERSE}\hspace{1ex}{\Large $LINE}\\newline" >> $F_TMP 
echo "\\subsection{$VERSE.}\begin{absolutelynopagebreak}{\large\fontseries{mb}\selectfont $LINE}\\newline" >> $F_TMP 
VERSE=$(expr $VERSE + 1)
done <$fin

cp $F_EN $F_EN_TMP
# format english text
sed -i 's/^/\\noindent\\emph{\\scriptsize\\fontseries{cl}\\selectfont /' $F_EN_TMP
# end of line
sed -i 's/$/}\\end{absolutelynopagebreak}/' $F_EN_TMP

F_TEX=$TMP_DIR/$NUM.tex
# interleave
awk '{print; if(getline < "'$F_EN_TMP'") print}' $F_TMP >> $F_TEX

# line breaks
sed -i '0~2 a\\' $F_TEX

# chapter title
NAME=$(basename --suffix=".tex" "$F_TEX")
NUM=$((10#$NAME))
STR="\\\section{$TITLE $NUM}\n"
sed -i "1s/^/$STR/" $F_TEX
echo "\Needspace{8\baselineskip}" >> $F_TEX

echo """
\documentclass[10pt,openany]{book}

\usepackage{fontspec}
\setmainfont [
  Path = ./../fonts/junicode2/,
  Extension = .otf,
  Numbers={Lining,Proportional},
  Punctuation={OldStyle},
  UprightFont = *-Regular,
  BoldFont = *-Bold,
  ItalicFont = *-Italic,
  BoldItalicFont= *-BoldItalic,
  FontFace={mb}{n}{*-Semibold},
  FontFace={eb}{n}{*-ExpandedBold},
  FontFace={cl}{n}{*-CondensedLight},
  FontFace={cl}{it}{*-CondensedLightItalic},
]{Junicode}

\usepackage{indentfirst}
\usepackage[skip=10pt plus1pt, indent=0pt]{parskip}

\usepackage[explicit]{titlesec}
\usepackage{needspace}

\titleformat{\section}[hang]
  {\LARGE\bfseries\centering}
  {\thesection}{0em}{#1}[]

\titlespacing{\section}{0pt}{0ex}{6ex}

\titleformat{\subsection}[runin]
  {\fontseries{eb}\selectfont}
  {\thesubsection}{0em}{\textsuperscript{#1}}[]

\setcounter{secnumdepth}{0}

\usepackage[
  papersize={8.75in,11.25in},
  layout=letterpaper,
  layouthoffset=0.125in,
  layoutvoffset=0.125in,
  right=1.5in,
  left=1.5in,
  top=0.75in,
  bottom=0.75in
]{geometry}

\newenvironment{absolutelynopagebreak}
  {\par\nobreak\vfil\penalty0\vfilneg
   \vtop\bgroup}
  {\par\xdef\tpd{\the\prevdepth}\egroup
   \prevdepth=\tpd}

\hyphenpenalty 10000
\exhyphenpenalty 10000

\begin{document}

\pagestyle{empty} 

\begin{flushleft}
""" >> $TMP_DIR/000.tex

echo """
\end{flushleft}

\end{document}
""" >> $TMP_DIR/999.tex

cat $TMP_DIR/*.tex > $TMP_DIR/out.tex

xelatex -halt-on-error -output-directory $TMP_DIR $TMP_DIR/out.tex

cp $TMP_DIR/*.pdf $SCRIPT_DIR
