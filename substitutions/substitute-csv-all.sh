#! /bin/bash

set -e
set -x

if [ $# -ne 1 ]; then
  echo "USAGE: $0 <FILE/DIR>"
  exit 0
fi

D=$(dirname "$0")
$D/substitution-csv.sh $D/i2j.csv $1
$D/substitution-csv.sh $D/names.csv $1
$D/substitution-csv.sh $D/ph2f.csv $1
$D/substitution-csv.sh $D/pronunciation.csv $1
$D/substitution-csv.sh $D/spelling.csv $1
$D/substitution-csv.sh $D/y2i.csv $1
