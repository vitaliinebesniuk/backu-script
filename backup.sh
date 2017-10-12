#!/bin/sh
WEBSERVERS_DIR=/home/vitalii
WEBSERVERS_NAME=pozitiff-website
NOW=$(date +%d-%m-%Y_%H:%M)
BACKUP_DST=/home/vitalii/backups
STATUS=$?

if [ ! -d $BACKUP_DST ]; then
  mkdir $BACKUP_DST
fi

cd $WEBSERVERS_DIR

ARCHIVE=$BACKUP_DST/$WEBSERVERS_NAME-$NOW.tar

echo Archiving  to $ARCHIVE

tar -cf $ARCHIVE $WEBSERVERS_NAME

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

find $BACKUP_DST -name '*.gz' -type f -mmin +10 -delete

#rsync -av --delete $BACKUP/ vitalii@192.168.48.141:/home/vitalii/backups/
