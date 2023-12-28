#!/bin/bash

set -x

function _replace() {
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

  sed -i 's/\bamen\b/āmen/g' $1
  sed -i 's/\bāmēn\b/āmen/g' $1
  sed -i 's/\bĀmēn\b/Āmen/g' $1
  sed -i 's/\bĀMĒN\b/ĀMEN/g' $1

  # intelligō -> intellegō
  sed -i 's/\bintelli/intelle/g' $1
  sed -i 's/\bIntelli/Intelle/g' $1
  sed -i 's/\bINTELLI/INTELLE/g' $1

  # exultō -> exsultō
  sed -i 's/\bexult/exsult/g' $1
  sed -i 's/\bExult/Exsult/g' $1
  sed -i 's/\bEXULT/EXSULT/g' $1
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
