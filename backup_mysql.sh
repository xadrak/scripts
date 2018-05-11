#!/bin/bash
# Backup do Mysql e repositorios em TGZ
# Criado Por Adriano Machado
# adriano@xadrak.com

DIA=`date +%Y%m%d%H%m`
FILES_DIR=/var/www/html/iamcs
DEST="/home/dropbox/Dropbox/01 TEKSEA/112 TI/03 IAMCS-desenv"
DEST="/tmp"


tar -zcf "$DEST/iamcs-backup-$DIA.tgz"  "$FILES_DIR"


FILE="$DEST/iamcs.sql".`date +%Y%m%d%H%m`
DBSERVER=127.0.0.1
DATABASE=iamcs
USER=
PASS=

# (2) in case you run this more than once a day, remove the previous version of the file
unalias rm     2> /dev/null
rm ${FILE}     2> /dev/null
rm ${FILE}.gz  2> /dev/null

# (3) do the mysql database backup (dump)

# use this command for a database server on a separate host:
#mysqldump --opt --protocol=TCP --user=${USER} --password=${PASS} --host=${DBSERVER} ${DATABASE} > ${FILE}

# use this command for a database server on localhost. add other options if need be.
/usr/bin/mysqldump --opt --user=${USER} --password=${PASS} ${DATABASE} > ${FILE}

# (4) gzip the mysql database dump file
gzip "$FILE"

# (5) show the user the result
echo "${FILE}.gz was created:"
ls -l "${FILE}.gz"

FD="/home/dropbox/Dropbox/01\ TEKSEA/112\ TI/03\ IAMCS-desenv/"

cp ${FILE}.gz "/home/dropbox/Dropbox/01 TEKSEA/112 TI/03 IAMCS-desenv/"
cp ${DEST}/iamcs-backup-$DIA.tgz "/home/dropbox/Dropbox/01 TEKSEA/112 TI/03 IAMCS-desenv/"
