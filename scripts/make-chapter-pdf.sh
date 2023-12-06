#!/bin/bash

set -x

FILE_LATIN="$1"
TITLE="$2"

DIR_CURRENT=$(pwd)
DIR_SCRIPT=$(dirname "$0")

DIR_LATIN=$(dirname "$FILE_LATIN")
DIR_ENGLISH=$DIR_LATIN/english
DIR_TMP=$DIR_SCRIPT/.tmp
NUM=$(basename --suffix=".txt" "$FILE_LATIN")
FILE_LATIN_TMP="$DIR_TMP"/"$NUM".tmp
FILE_ENGLISH="$DIR_ENGLISH"/"$NUM".txt
FILE_ENGLISH_TMP="$DIR_TMP"/"$NUM"EN.tmp
FILE_TEX=$DIR_TMP/$NUM.tex

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# create directory to dump all our temporory files into
rm -rfv $DIR_TMP
mkdir -v $DIR_TMP

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# process the Latin text and add verse numbers
VERSE=1
fin=$FILE_LATIN
while read -r LINE; do
PRELINE="\begin{absolutelynopagebreak}{\large\fontseries{mb}\selectfont"
POSTLINE="}\newline"
echo \
  "\subsection{$VERSE.} $PRELINE $LINE $POSTLINE" \
  >> $FILE_LATIN_TMP
VERSE=$(expr $VERSE + 1)
done <$fin

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# process the English text next
fin=$FILE_ENGLISH
while read -r LINE; do
PRELINE="\noindent\emph{\scriptsize\fontseries{cl}\selectfont"
POSTLINE="}\end{absolutelynopagebreak}"
echo \
  "$PRELINE $LINE $POSTLINE" \
  >> $FILE_ENGLISH_TMP
done <$fin

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# interleave the Latin and English, final formatting
# TODO: replace with sed?
awk \
  '{print; if(getline < "'$FILE_ENGLISH_TMP'") print}' \
  $FILE_LATIN_TMP >> $FILE_TEX
# add empty line between each Latin-English paired verse
sed -i '0~2 a\\' $FILE_TEX

# add chapter title to beginning
CHAPTER=$((10#$(basename --suffix=".tex" "$FILE_TEX")))
STR="\\\section{$TITLE $CHAPTER}\n"
sed -i "1s/^/$STR/" $FILE_TEX
echo "\Needspace{8\baselineskip}" >> $FILE_TEX

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# marshall all the tex files into one and feed it to xelatex
cp $DIR_SCRIPT/tex/make-chapter-pdf/head.tex $DIR_TMP/000.tex
cp $DIR_SCRIPT/tex/make-chapter-pdf/tail.tex $DIR_TMP/999.tex
cat $DIR_TMP/*.tex > $DIR_TMP/out.tex

xelatex -halt-on-error -output-directory $DIR_TMP $DIR_TMP/out.tex

cp $DIR_TMP/*.pdf $DIR_CURRENT
