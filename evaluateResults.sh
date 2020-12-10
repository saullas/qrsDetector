#!/bin/bash
DATABASE=$1
cd $DATABASE/1.0.0/

for file in *.qrs
do
  bxb -r $(basename "$file" | cut -d. -f1) -a atr qrs -l bxb1.txt bxb2.txt
done

FILENAME="${DATABASE}Results.txt"
sumstats bxb1.txt bxb2.txt > ../../$FILENAME