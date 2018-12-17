#!/bin/bash

# epochTime=$(date +%s)

# echo $epochTime

# cat /Users/sea01/Documents/repos/infrastructure-configs/bind/db.oddschecker.com

# grep= $(grep "[0-9]+ ;" /Users/sea01/Documents/scripts/test)
# echo $grep

# cat /Users/sea01/Documents/scripts/test | awk '{gsub(/[0-9]+ ; s/, "epochTime, ; s")}'

 sed -i -pe 's/[0-9]+ ;/123/g' /Users/sea01/Documents/scripts/test

# cat /Users/sea01/Documents/scripts/test

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
