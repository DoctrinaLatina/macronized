#!/usr/bin/env python3

def ReadCSV(file_path, la, en):
  la.clear()
  en.clear()

  f = open(file_path, 'r')
  line = f.readline()

  line_count = 1

  while line:
    # key ^ latin line ^ english line
    # -- OR --
    # latin line ^ english line
    s = line.split('^')
    if (2 == len(s)):
      key = str(line_count)
      line_la = s[0].strip()
      line_en = s[1].strip()
    elif (3 == len(s)):
      key = s[0].strip()
      line_la = s[1].strip()
      line_en = s[2].strip()

    la[key] = line_la
    en[key] = line_en
    line = f.readline()
    line_count = line_count + 1

dir_fonts = "./../fonts"
dir_images = "./../images"

def WriteTexSection(f, la, en, title="", inscription="", is_numbered=True):
  tex_section = r"""
  \pagebreak[3]\section{$TITLE}
  """
  tex_inscription = r"""
  \begin{center}
  \emph{\scriptsize $INSCRIPTION }
  \end{center}
  """
  tex_verse = r"\hskip0.05in {$^\textsuperscript{\emph $VERSE}$}"
  tex_line_la = r"""
  \begin{absolutelynopagebreak} $TEX_VERSE { $LA }\newline"""
  tex_line_en = r"""
  \noindent\emph{\scriptsize $EN }\end{absolutelynopagebreak}\vspace{0.04in}
  """

  if title:
    f.write(tex_section.replace(r"$TITLE", title))

  if inscription:
    f.write(tex_inscription.replace(r"$INSCRIPTION", inscription))
    f.write(r"\vspace{0.06in}")
  else:
    f.write(r"\vspace{0.18in}")

  verses = sorted(la, key = int)
  for verse in verses:
    line = tex_line_la.replace("$LA", la[verse]) + \
           tex_line_en.replace("$EN", en[verse])

    if is_numbered:
      line_verse = tex_verse.replace("$VERSE", verse)
      line = line.replace("$TEX_VERSE", line_verse)
    else:
      line = line.replace("$TEX_VERSE", "")

    f.write(line)

  tex_section_end = r"""
  \Needspace{8\baselineskip}
  """
  f.write(tex_section_end)

tex_head = r"""% Generated using Python, do not hand edit!
\documentclass[10pt,openany]{book}

\usepackage[
  paperwidth=6.08in,
  paperheight=8.52in,
  right=0.75in,
  left=0.75in,
  top=0.9in,
  bottom=0.5in,
  headsep=0.12in,
]{geometry}

\usepackage{fontspec}
\defaultfontfeatures{Ligatures={NoCommon}}

\setmainfont [
  Path = $DIRFONTS/walleye/,
  Extension = .ttf,
  UprightFont = *-Regular,
  BoldFont = *-Bold,
  ItalicFont = *-Italic,
  BoldItalicFont= *-BoldItalic
]{Walleye}

\usepackage{graphicx}
\graphicspath{{$DIRIMAGES}}

\newenvironment{absolutelynopagebreak}
  {\par\nobreak\vfil\penalty0\vfilneg
   \vtop\bgroup}
  {\par\xdef\tpd{\the\prevdepth}\egroup
   \prevdepth=\tpd}

\hyphenpenalty 10000
\exhyphenpenalty 10000

\usepackage{indentfirst}
\usepackage[skip=10pt plus1pt, indent=0pt]{parskip}

\usepackage[explicit]{titlesec}
\usepackage{needspace}

\titleformat{\section}[block]
  {\addfontfeature{LetterSpace=30.0}\bfseries\filcenter}
  {\thesection}{}{ #1 }[]
\titlespacing{\section}{0ex}{2ex}{0ex}

\usepackage{fancyhdr}
\usepackage{extramarks}
\pagestyle{fancy}
\fancyhf{}

\renewcommand{\sectionmark}[1]{
  \markboth{\addfontfeature{LetterSpace=20.0} #1}
           {\addfontfeature{LetterSpace=20.0} #1}
}

%\fancyhead[C]{}
\fancyhead[LO]{\small{\thepage}}
\fancyhead[LE]{\scriptsize{\emph\firstrightmark}}
\fancyhead[RE]{\small{\thepage}}
\fancyhead[RO]{\scriptsize{\emph\firstrightmark}}
\renewcommand{\headrulewidth}{0.0pt}
\renewcommand{\footrulewidth}{0.0pt}

\setcounter{secnumdepth}{0}
\begin{document}

  % TITLE PAGE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  \thispagestyle{empty}
  \begin{center}
  \topskip0pt
  %\vspace*{\fill}
    \null
    \vspace{1.5in}
  {\huge\bfseries\addfontfeature{LetterSpace=10.0} LIBER PSALMŌRUM}
  \vspace{2ex}

  {\huge\bfseries\addfontfeature{LetterSpace=10.0} DĀVĪDIS}
  \vspace{6ex}

  {\large\bfseries\addfontfeature{LetterSpace=10.0} CUM APICIBUS}
  \vspace{8ex}

  \vspace*{\fill}
  \end{center}
  \newpage

  % INFO PAGE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  \thispagestyle{empty}
  \begin{flushleft}
  \topskip0pt
  %\vspace*{\fill}
  \vspace{8ex}
  \begin{footnotesize}
  \noindent
  Liber Psalmorum Davidis Cum Apicibus, build date: \today

  \noindent
  This is a free and unencumbered work released into the public domain.

  \noindent
  Anyone is free to copy, modify, publish, use, sell, or distribute this work, either in print or digital form, for any purpose, commercial or non-commercial, and by any means.

  \noindent
  In jurisdictions that recognize copyright laws, the author or authors of this work dedicate any and all copyright interest in the work to the public domain. We make this dedication for the benefit of the public at large and to the detriment of our heirs and successors. We intend this dedication to be an overt act of relinquishment in perpetuity of all present and future rights to this document under copyright law.

  \noindent
  THE WORK IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE WORK OR THE USE OR OTHER DEALINGS IN THE WORK.
  \vspace{4ex}

  \noindent
  For further information, comments, questions, or corrections, please visit \textbf{doctrinalatina.com}.

  \end{footnotesize}
  \vspace*{\fill}
  \end{flushleft}
  \newpage

  % INTRO PRAYER PAGE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  \thispagestyle{empty}
  \topskip0pt
  \null

  \begin{figure}
    \centering
    \vspace{1in}
    \includegraphics[scale=0.25]{david.png}
  \end{figure}

  \newpage

  % BEGIN PSALMS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  \clearpage
  \pagenumbering{arabic}
  \begin{flushleft}"""
tex_tail = r"""
  \end{flushleft}
\end{document}"""

tex_head = tex_head.replace("$DIRFONTS", dir_fonts)
tex_head = tex_head.replace("$DIRIMAGES", dir_images)

psalms_root_dir = "./../vulgata/01-vetus-testamentum/21-psalmi/combined/"

antifonae_la = {}
antifonae_en = {}
ReadCSV(psalms_root_dir + "antifonae.txt", antifonae_la, antifonae_en)

inscription_la = {}
inscription_en = {}
ReadCSV(psalms_root_dir + "inscriptiones.txt", inscription_la, inscription_en)
print(inscription_en)

file_tex_out = "out.tex"
f = open(file_tex_out, "w")

f.write(tex_head + "\n")

psalm_la = {}
psalm_en = {}
for n in range(1, 151):
  chapter = str(n)

  ReadCSV(psalms_root_dir + chapter.zfill(3) + ".txt", psalm_la, psalm_en)

  inscription = ""
  if chapter in inscription_la:
    inscription = inscription_la[chapter]

  WriteTexSection(f, \
                  psalm_la, \
                  psalm_en, \
                  "PSALMUS " + chapter, \
                  inscription)

f.write(tex_tail + "\n")
f.close()

import subprocess
subprocess.run(["xelatex", "-halt-on-error", file_tex_out])
