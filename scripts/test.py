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

psalms_root_dir = "./../vulgata/01-vetus-testamentum/21-psalmi/combined/"

antifonae_la = {}
antifonae_en = {}
ReadCSV(psalms_root_dir + "antifonae.txt", antifonae_la, antifonae_en)
print(antifonae_la)
print(antifonae_en)

inscriptiones_la = {}
inscriptiones_en = {}
ReadCSV(psalms_root_dir + "inscriptiones.txt", inscriptiones_la, inscriptiones_en)
print(inscriptiones_la)
print(inscriptiones_en)

psalm_la = {}
psalm_en = {}
ReadCSV(psalms_root_dir + "144.txt", psalm_la, psalm_en)
print(psalm_la)
print(psalm_en)
