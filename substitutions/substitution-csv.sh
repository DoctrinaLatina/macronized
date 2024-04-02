#! /bin/bash

set -e
set -x

if [ $# -ne 2 ]; then
  echo "USAGE: $0 <CSV> <FILE/DIR>"
  exit 0
fi

function _replace() {
  CSV=$1
  INPUT=$2
  while IFS="," read -r OLDWORD OLDSTEM NEWWORD NEWSTEM
  do
    echo "Replacing \"$OLDWORD\" ($OLDSTEM) with \"$NEWWORD\" ($NEWSTEM)"

    UPOLDSTEM=${OLDSTEM^}
    UPNEWSTEM=${NEWSTEM^}
    CAPSOLDSTEM1=${OLDSTEM^^}
    CAPSOLDSTEM=${CAPSOLDSTEM1//'\B'/'\b'}
    CAPSNEWSTEM=${NEWSTEM^^}

    sed -i "s/$OLDSTEM/$NEWSTEM/g" $INPUT
    sed -i "s/$UPOLDSTEM/$UPNEWSTEM/g" $INPUT
    sed -i "s/$CAPSOLDSTEM/$CAPSNEWSTEM/g" $INPUT
  done < <(tail -n +2 $CSV)
}

if [ $# -eq 0 ]; then
  echo "USAGE: $0 [DIR/FILE]"
  exit 1
fi

if test -f $2; then
  _replace $1 $2
elif test -d $2; then
  for F in $2/*; do
    if test -f $F; then
      _replace $1 $F
    fi
  done
fi
