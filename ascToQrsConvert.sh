#!/bin/bash
cd mitdb/1.0.0/

for file in *.asc
do
  wrann -r $(basename "$file" | cut -d. -f1) -a qrs < $(basename "$file");
done