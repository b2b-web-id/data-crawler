#!/bin/sh

for i in `find . -iname "*.dbf"`
do
 dbfdump.pl --fs "|" $i > `basename -s .dbf $i`.csv
done
