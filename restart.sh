#!/bin/bash

# sudo su oddschecker

env=1
cd /Users/sea01/Downloads
for e in uploads uploads_test uploads_dev
do
  dev=1
  for d in OC TA TB MA MB
  do
    mkdir -p "home/oddschecker/$e/$d/EN/content/pages/insight/cricket"
    # cd "/home/oddschecker/$e/$d/EN/content/pages/insight"
    # mkdir cricket
    let "dev+=1"
done
let "env+=1"
done
