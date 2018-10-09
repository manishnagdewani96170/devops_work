SUFFIX=`date +%Y-%m-%d`
DBUSER="your database user"
DBHOST="your database host"
DBPASS="your password"
BACKUPDIR="/test_user/db_scripts"

DBS=`mysql -u$DBUSER -h$DBHOST -p$DBPASS -e"show databases"`

mkdir $BACKUPDIR/$SUFFIX
cd $BACKUPDIR/$SUFFIX
for DATABASE in $DBS
do
if [ $DATABASE != "information_schema" ]; then
FILENAME=$SUFFIX-mysql-$DATABASE.gz
mysqldump -u$DBUSER -h$DBHOST -p$DBPASS $DATABASE | gzip --best > $FILENAME
fi
done
zip -r $SUFFIX.zip $SUFFIX
