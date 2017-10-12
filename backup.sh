#!/bin/sh
WEBSERVERS_DIR=/home/vitalii
NOW=$(date +%d-%m-%Y_%H:%M)
BACKUP_DST=$HOME/backups
STATUS=$?

if [ ! -d $BACKUP_DST ]; then
  mkdir $BACKUP_DST
fi

cd $WEBSERVERS_DIR

ARCHIVE=$BACKUP_DST/pozitiff-website_$NOW.tar

echo Archiving  to $ARCHIVE

tar -cf $ARCHIVE pozitiff-website/

if [ $STATUS ]; then
  echo TAR archiving done!
else
  echo TAR Error!
fi

gzip $ARCHIVE

if [ $STATUS ]; then
  echo GZIP archiving done!
else
  echo GZIP Error!
fi

find $BACKUP_DST -name 'pozitiff-website_*' -type f -mtime +7 -exec rm {} \;

#rsync -av --delete $BACKUP/ vitalii@192.168.48.141:/home/vitalii/backups/
