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
