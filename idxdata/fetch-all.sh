#!/bin/sh

# rm all index.html
for i in `find . -name "index.html"`
do
 rm $i
done
# fetch web site
wget -c -r -w 1 -t 1 www.idxdata3.co.id
wget -c -r -w 1 -t 1 www.idxdata2.co.id
wget -c -r -w 1 -t 1 www.idxdata.co.id
