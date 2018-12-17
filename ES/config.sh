#!/bin/bash

# We want to archive previous index, here last month index
INDEXNAME="oc-betslips"`date --date="last month" +"%Y-%m"` # this had better match the index name in ES

INDEXDIR="/cygdrive/d/Data/cedric.vidal/apps/elasticsearch-0.20.2-node-1/data/cls-log-test/nodes/0/indices"
CURDIR="/cygdrive/d/Data/cedric.vidal/AMQ/CLS/backup-es"

# Local configuration
BACKUPCMD="cp"
BACKUPTARGET=$CURDIR"/es-tape/$INDEXNAME"

# S3 Configuration
# BACKUPCMD="/usr/local/backupTools/s3cmd --config=/usr/local/backupTools/s3cfg put"
# BACKUPTARGET="s3://backups/elasticsearch/$INDEXNAME"

BACKUPDIR=$CURDIR"/es-backups"

ESURL="http://localhost:9200"
TMPDIR=$CURDIR"/tmp"
MAPPING=$BACKUPDIR/$INDEXNAME-mapping.json
RESTARTCMD="" #/etc/init.d/es restart"
