#!/bin/bash

set -x

function _replace() {
  # !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  # Normalize "ph" digraph to "f" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

  # Alphaeus -> Alfeus
  sed -i 's/\bAlphae/Alfe/g' $1

  # Asaph -> Āsāf
  sed -i 's/\ASAPH\b/ĀSĀF/g' $1
  sed -i 's/\bAsaph\b/Āsāf/g' $1

  # Beelphegor -> Baalfegor
  sed -i 's/\bBeelphegor\b/Baalfegor/g' $1

  # blasphēmia -> blasfēmia
  sed -i 's/\bBlasphēmi/Blasfēmi/g' $1
  sed -i 's/\bblasphēmi/blasfēmia/g' $1

  # blasphēmō -> blasfēmō
  sed -i 's/\bBlasphēm/Blasfēm/g' $1
  sed -i 's/\bblasphēm/blasfēm/g' $1

  # Capharnāum -> Cafarnāum
  sed -i 's/\bCAPHARNAUM\b/CAFARNAUM/g' $1
  sed -i 's/\bCapharnaum\b/Cafarnaum/g' $1

  # colaphus -> colafus
  sed -i 's/\bColaph/Colaf/g' $1
  sed -i 's/\bcolaph/colaf/g' $1

  # cophinus -> cofinus
  sed -i 's/\bCOPHIN/COFIN/g' $1
  sed -i 's/\bcophin/cofin/g' $1

  # Ephraim -> Efraim
  sed -i 's/\EPHRAIM\b/EFRAIM/g' $1
  sed -i 's/\bEphraim\b/Efraim/g' $1

  # Ephrata -> Efrata
  sed -i 's/\bEPHRATA\b/EFRATA/g' $1
  sed -i 's/\bEphrata\b/Efrata/g' $1

  # gazophylacium -> gazofilacium
  sed -i 's/\bGazophylaci/Gazofilaci/g' $1
  sed -i 's/\bgazophylaci/gazofilaci/g' $1

  # Ioseph -> Iōsēf
  sed -i 's/\bIOSEPH\b/IŌSĒF/g' $1
  sed -i 's/\bIoseph\b/Iōsēf/g' $1
  sed -i 's/\bIōsēph\b/Iōsēf/g' $1

  # orphanus -> orfanus
  sed -i 's/\bORPHAN/ORFAN/g' $1
  sed -i 's/\borphan/orfan/g' $1

  # phantasma -> fantasma
  sed -i 's/\bPhantasma/Fantasma/g' $1
  sed -i 's/\bphantasma/fantasma/g' $1

  # pharetra -> faretra
  sed -i 's/\bPHARETR/FARETR/g' $1
  sed -i 's/\bPharetr/Faretr/g' $1
  sed -i 's/\bpharetr/faretr/g' $1

  # (pseudo)prophēta -> (pseudo)profēta
  sed -i 's/PROPHĒT/PROFĒT/g' $1
  sed -i 's/Prophēt/Profēt/g' $1
  sed -i 's/prophēt/profēt/g' $1
  sed -i 's/\bprophet/profēt/g' $1

  # sulphur -> sulfur
  sed -i 's/\bSULPHUR/SULFUR/g' $1
  sed -i 's/\bsulphur/sulfur/g' $1

  # Syrophoenissa -> Syrofoeniss
  sed -i 's/\bSyrophoeniss/Syrofoeniss/g' $1

  # !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  # Normalize "y" to "i" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

  # abyssus -> abissus
  sed -i 's/\bAbyss/Abiss/g' $1
  sed -i 's/\babyss/abiss/g' $1

  # Aegyptum -> Aegiptum
  sed -i 's/\bAegypt/Aegipt/g' $1

  # Babylōn -> Babilōn
  sed -i 's/\bBabylōn/Babilōn/g' $1

  # cymbalum -> cimbalum
  sed -i 's/\bCymbal/Cimbal/g' $1
  sed -i 's/\bcymbal/cimbal/g' $1

  # cynomia -> cinomia
  sed -i 's/\bCynomi/Cinomi/g' $1
  sed -i 's/\bcynomi/cinomi/g' $1

  # hymnus -> himnus
  sed -i 's/\bHYMN/HIMN/g' $1
  sed -i 's/\bHymn/Himn/g' $1
  sed -i 's/\bhymn/himn/g' $1

  # hyssōpum -> hissōpum
  sed -i 's/\bHyssōp/Hissōp/g' $1
  sed -i 's/\bhyssōp/hissōp/g' $1

  # lacryma -> lacrima
  sed -i 's/\bLacrym/Lacrim/g' $1
  sed -i 's/\blacrym/lacrim/g' $1

  # nycticorax -> nicticorax
  sed -i 's/Nycticora/Nicticora/g' $1
  sed -i 's/nycticora/nicticora/g' $1

  # synagōga -> sinagōga
  sed -i 's/Synagōg/Sinagōg/g' $1
  sed -i 's/synagōg/sinagōg/g' $1

  # Tyrus -> Tirus
  sed -i 's/\bTyr/Tir/g' $1

  # tympanum -> timpanum
  sed -i 's/\btympan/timpan/g' $1

  # Syrofoeniss -> Sirofoeniss
  sed -i 's/\bSyrofoeniss/Sirofoeniss/g' $1
}

if [ $# -eq 0 ]; then
  echo "USAGE: $0 [DIR/FILE]"
  exit 1
fi

if test -f $1; then
  _replace $1
elif test -d $1; then
  for F in $1/*; do
    if test -f $F; then
      _replace $F
    fi
  done
fi
