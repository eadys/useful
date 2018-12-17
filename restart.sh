#!/bin/bash

env=1
cd /path/to/file
for e in uploads uploads_test uploads_dev
do
  dev=1
  for d in OC TA TB MA MB
  do
    mkdir -p "home/example/$e/$d/EN/content/pages/insight/sport"
    let "dev+=1"
done
let "env+=1"
done
