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
  \pagebreak[3]\section{$TITLE}"""
  tex_inscription = r"""
  \begin{center}
  \emph{\scriptsize $INSCRIPTION }\vspace{0.06in}
  \end{center}
  """
  tex_verse = r"{$^\textsuperscript{\emph $VERSE}$}"
  tex_line_la = r"""
  \begin{absolutelynopagebreak} \hskip0.05in $TEX_VERSE { $LA }\newline"""
  tex_line_en = r"""
  \noindent\emph{\scriptsize $EN }\end{absolutelynopagebreak}\vspace{0.04in}
  """

  if title:
    f.write(tex_section.replace(r"$TITLE", title))

  if inscription:
    f.write(tex_inscription.replace(r"$INSCRIPTION", inscription))

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
  top=1.0in,
  bottom=0.5in
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

\titleformat{\section}[hang]
  {\addfontfeature{LetterSpace=30.0}\bfseries\centering}
  {\thesection}{}{\fontdimen2\font=10pt #1 }[]
\titlespacing{\section}{0ex}{1ex}{0ex}

\usepackage{fancyhdr}
\usepackage{extramarks}
\pagestyle{fancy}
\fancyhf{}

\renewcommand{\sectionmark}[1]{
  \markboth{\addfontfeature{LetterSpace=20.0} #1}
           {\addfontfeature{LetterSpace=20.0} #1}
}

\fancyhead[C]{\scriptsize{\emph\firstrightmark}}
\fancyhead[LO]{\scriptsize{\thepage}}
\fancyhead[RE]{\scriptsize{\thepage}}
\renewcommand{\headrulewidth}{0.0pt}
\renewcommand{\footrulewidth}{0.0pt}

\setcounter{secnumdepth}{0}
\begin{document}
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

psalm_la = {}
psalm_en = {}
ReadCSV(psalms_root_dir + "144.txt", psalm_la, psalm_en)

f = open("out.tex", "w")
f.write(tex_head + "\n")

WriteTexSection(f, psalm_la, psalm_en, "PSALMUS 144", inscription_la['144'])

f.write(tex_tail + "\n")
f.close()
