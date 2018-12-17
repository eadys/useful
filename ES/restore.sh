#!/bin/bash
# Performs 'rotation' of ES indices. Maintains only 8 indicies (1 week) of logstash logs; this script
# is to be run at midnight daily and removes the oldest one (as well as any 1970s-era log indices,
# as these are a product of timestamp fail). Please note the insane amount of error-checking
# in this script, as ES would rather delete everything than nothing…
# Before we do anything, let's get rid of any nasty 1970s-era indices we have floating around

. ./config.sh

echo "Checking that index doesn't already exist in ES"
if [ `curl -sI $ESURL/$INDEXNAME | grep OK | wc -l` -eq 1 ]
then
  echo "Index $INDEXNAME already exists, delete it before restoring. exiting"
  exit 0
fi

echo "Restoring index $INDEXNAME"

# create index and mapping
echo -n "Creating index and mappings ..."
curl -XPUT "$ESURL/$INDEXNAME/" -d @$MAPPING > /dev/null 2>&1
echo "DONE!"

# extract our data files into place
echo -n "Restoring index (this may take a while) ..."
cd $INDEXDIR
tar -zxvf $BACKUPDIR/$INDEXNAME.tar.gz
echo "DONE!"

# restart ES to allow it to open the new dir and file data
echo -n "Restarting Elasticsearch ..."
$RESTARTCMD
echo "DONE!"