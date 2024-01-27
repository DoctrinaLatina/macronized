#!/bin/bash

set -x

function _replace() {
  # It appears that the final 'i' wasn't always short for these words; some
  # uses would lengthen it. We will favor the long vowel ending in order to
  # make pronunciation more "natural" and to find some small common ground with
  # modern ecclesiastical pronunciation.
  # mihi -> mihī
  # tibi -> tibī
  # sibi -> sibī
  # ibi -> ibī
  # ubi -> ubī
  sed -i 's/\bmihi\b/mihī/g' $1
  sed -i 's/\bMihi\b/Mihī/g' $1

  sed -i 's/\btibi\b/tibī/g' $1
  sed -i 's/\bTibi\b/Tibī/g' $1

  sed -i 's/\bsibi\b/sibī/g' $1
  sed -i 's/\bSibi\b/Sibī/g' $1

  sed -i 's/\bibi\b/ibī/g' $1
  sed -i 's/\bIbi\b/Ibī/g' $1

  sed -i 's/\bubi\b/ubī/g' $1
  sed -i 's/\bUbi\b/Ubī/g' $1

  # Favor short 'e' to align with pronunciation that became standardized
  # in the early middle ages (or earier).
  # āmēn -> āmen
  sed -i 's/\bamen\b/āmen/g' $1
  sed -i 's/\bāmēn\b/āmen/g' $1
  sed -i 's/\bĀmēn\b/Āmen/g' $1
  sed -i 's/\bĀMĒN\b/ĀMEN/g' $1

  # appropinquō -> adpropinquō
  sed -i 's/\bappropinqu/adpropinqu/g' $1
  sed -i 's/\bAppropinqu/Adpropinqu/g' $1

  # intelligō -> intellegō
  sed -i 's/\bintelli/intelle/g' $1
  sed -i 's/\bIntelli/Intelle/g' $1
  sed -i 's/\bINTELLI/INTELLE/g' $1

  # exultātiō -> exsultātiō
  # exultō -> exsultō
  sed -i 's/\bexult/exsult/g' $1
  sed -i 's/\bExult/Exsult/g' $1
  sed -i 's/\bEXULT/EXSULT/g' $1

  # sēmetipse -> sēmet ipse
  sed -i 's/\bsēmetip/sēmet ip/g' $1
  sed -i 's/\bsemetip/sēmet ip/g' $1

  # annūntiō -> adnūntiō
  sed -i 's/\bannūnti/adnūnti/g' $1
  sed -i 's/\bAnnūnti/Adnūnti/g' $1

  # Regularize usage of "a/ab"
  # abs tē -> ā tē
  sed -i 's/\babs tē\b/ā tē/g' $1
  sed -i 's/\babs te\b/ā tē/g' $1
  sed -i 's/\bAbs te\b/Ā tē/g' $1

  # Israel -> Isrāhēl
  sed -i 's/\bIsrael\b/Isrāhēl/g' $1
  sed -i 's/\bIsrāēl\b/Isrāhēl/g' $1

  # Sion -> Siōn
  sed -i 's/\bSion\b/Siōn/g' $1
  sed -i 's/\bSīōn\b/Siōn/g' $1

  # suppress rare first person singular future indicative form
  # mētībor -> mētiar
  sed -i 's/\bmetibor\b/mētiar/g' $1
  sed -i 's/\bmētībor\b/mētiar/g' $1
  sed -i 's/\bMētībor\b/Mētiar/g' $1

  # exurgō -> exsurgō
  # catch mistake that snuck in...
  sed -i 's/\bExurgē\b/Exsurge/g' $1
  sed -i 's/\bexurgē\b/exsurge/g' $1
  sed -i 's/\bexurg/exsurg/g' $1
  sed -i 's/\bExurg/Exsurg/g' $1

  # Remove alternative form of "hīs"
  sed -i 's/\bIĪS\b/HĪS/g' $1
  sed -i 's/\bIīs\b/Hīs/g' $1
  sed -i 's/\biīs\b/hīs/g' $1
  sed -i 's/\biis\b/hīs/g' $1

  # lacryma -> lacrima
  sed -i 's/\bLacrym/Lacrim/g' $1
  sed -i 's/\blacrym/lacrim/g' $1

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
  sed -i 's/\bCAPHARNĀUM\b/CAFARNĀUM/g' $1
  sed -i 's/\bCapharnāum\b/Cafarnāum/g' $1

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
