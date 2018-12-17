#!/bin/bash

# epochTime=$(date +%s)

# echo $epochTime

# cat infrastructure-configs/bind/db.example.com

# grep= $(grep "[0-9]+ ;" /path/to/scripts/test)
# echo $grep

# cat /path/to/scripts/test | awk '{gsub(/[0-9]+ ; s/, "epochTime, ; s")}'

 sed -i -pe 's/[0-9]+ ;/123/g' /path/to/scripts/test

# cat /path/to/scripts/test

file=test

for f in $file
do
gawk -i inplace '{gsub(/[0-9]+ ; s/, systime() " ; s"); print}' $f
done

cd /tmp/bind 
for f in @option.file@
do
gawk -i inplace '{gsub(/[0-9]+ ; s/, systime() " ; s"); print}' $f
done
