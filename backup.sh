#!/bin/sh
HOME=/home/vitalii
NOW=$(date +%d-%m-%Y_%H:%M)
BACKUP=$HOME/backups

if [ ! -d $BACKUP ]; then
  mkdir $BACKUP
fi

cd $HOME

ARCHIVE=$BACKUP/pozitiff-website_$NOW.tar

echo Archiving  to $ARCHIVE

tar -cf $ARCHIVE pozitiff-website/

if [ $? ]; then
  echo TAR archiving done!
else
echo TAR Error!
fi

gzip $ARCHIVE

if [ $? ]; then
  echo GZIP archiving done!
else
echo GZIP Error!
fi

find $BACKUP -name 'pozitiff-website_*' -type f -mtime +7 -exec rm {} \;

rsync -a $BACKUP/pozitiff-website_$NOW.tar.gz vitalii@192.168.48.122:/home/vitalii/backups
