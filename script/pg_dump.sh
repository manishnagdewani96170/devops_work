#!/bin/sh
date_str=$(date +"%Y%m%d_%H%M%S")

dbs=`psql -U test_user -lt | cut -d \| -f 1 | grep -v template | grep -v -e '^\s*$' | sed -e 's/  *$//'|  tr '\n' ' '`
echo "Will backup: $dbs to $backup_dir" >> /tmp/db_backup_info.log
cd /test_user/db_scripts
mkdir $date_str
for db in $dbs; do
  echo "Starting backup for $db" >> /tmp/db_backup_info.log
  filename=$db.$date_str.sql.gz
  sudo -u postgres pg_dump -U test_user -v $db -F p 2>> /tmp/db_backup.log | gzip > $filename
  mv $filename /$date_str
done
zip -r $date_str.zip $date_str
