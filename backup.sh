#!/bin/sh
WEBSERVERS_DIR=/home/vitalii
WEBSERVERS_NAME=pozitiff-website
NOW=$(date +%d-%m-%Y_%H-%M)
BACKUP_DST=/home/vitalii/backups
BACKUP_SERVER=vitalii@192.168.48.141
STATUS=$?

if [ ! -d $BACKUP_DST ]; then
  mkdir $BACKUP_DST
fi

cd $WEBSERVERS_DIR

TAR=tar
CHECK_TAR=$(which $TAR)
if [ $STATUS = 0 ]; then
  echo "Package $TAR is installed"
else
  echo "Installing $TAR package..."
  sudo apt-get -y install $TAR
fi

ARCHIVE=$BACKUP_DST/$WEBSERVERS_NAME-$NOW.tar.gz

echo Archiving  to $ARCHIVE

tar -zcf $ARCHIVE $WEBSERVERS_NAME

if [ $STATUS = 0 ]; then
  echo TAR archiving done!
else
  echo TAR Error!
fi

find $BACKUP_DST -name '*.gz' -type f -mmin +10 -delete

rsync -av --delete $BACKUP_DST $BACKUP_SERVER:/home/vitalii/
