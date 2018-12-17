n we backup our indexes! this script should run at like 3 AM every first day of the month, after logstash
# rotates to a new ES index and theres no new data coming in to the old one. we grab metadatas,
# compress the data files and backs up to whatever long term storage.

. ./config.sh

echo "Checking that index exist in ES"
if [ `curl -sI $ESURL/$INDEXNAME | grep OK | wc -l` -eq 0 ]
then
  echo "Index $INDEXNAME doesn't exist, nothing to backup"
  exit 0
fi

# create mapping file with index settings. this metadata is required by ES to use index file data
echo -n "Backing up metadata of index $INDEXNAME ... "
curl -XGET -o $TMPDIR/mapping $ESURL"/$INDEXNAME/_mapping?pretty=true" > /dev/null 2>&1
sed -i '1,2d' $TMPDIR/mapping #strip the first two lines of the metadata
echo '{"settings":{"number_of_shards":5,"number_of_replicas":1},"mappings":{' > $MAPPING
# prepend hardcoded settings metadata to index-specific metadata
cat $TMPDIR/mapping >> $MAPPING
echo "DONE!"

# now lets tar up our data files. these are huge, so lets be nice
echo -n "Backing up data files of index $INDEXNAME (this may take some time) ... "
mkdir -p $BACKUPDIR
cd $INDEXDIR
nice -n 19 tar -zcf $BACKUPDIR/$INDEXNAME.tar.gz $INDEXNAME
echo "DONE!"

# push both tar.gz and metadatas to tape
echo -n "Saving to tape (this may take some time) ..."
$BACKUPCMD $BACKUPDIR/$INDEXNAME.tar.gz $BACKUPTARGET.tar.gz
$BACKUPCMD $MAPPING $BACKUPTARGET-mapping.json
echo "DONE!"

# cleanup tmp files
rm $TMPDIR/mapping
