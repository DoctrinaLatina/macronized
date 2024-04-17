#!/bin/bash

set -x

SCRIPT_DIR=$(realpath $(dirname "$0"))
cd $SCRIPT_DIR

PSALM_DIR=$SCRIPT_DIR/../vulgate/01-vetus-testamentum/21-psalmi

rm -rf psalms
mkdir psalms

readarray -t ARRAY < $PSALM_DIR/checklist.txt

for i in "${ARRAY[@]}"
do
  NUM="$i"
  ./make-chapter-pdf.sh $PSALM_DIR/$NUM.txt PSALMUS
  mv out.pdf psalms/$NUM.pdf
done

