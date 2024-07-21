#!/bin/bash

# Diretório onde os backups serão armazenados
PUBLIC_DIR="/SDServer/jakarta/webapps/iweb/public"
BACKUP_DIR="/___temp_gamedb_backup"
TIMESTAMP=$(date +\%Y-\%m-\%d_\%H-\%M-\%S)
ZIP_FILE="${PUBLIC_DIR}/sds-${TIMESTAMP}.zip"

# Comando para fazer o backup com a data e hora atuais
rm -rfv ${TEMP_BACKUP_DIR}
mkdir ${TEMP_BACKUP_DIR}
mkdir ${BACKUP_DIR}

mkdir ${BACKUP_DIR}/gamedbd
mkdir ${BACKUP_DIR}/backdbd
mkdir ${BACKUP_DIR}/uniquenamed

cp -rfv /SDServer/gamedbd/dbhomewdb ${BACKUP_DIR}/gamedbd/
cp -rfv /SDServer/backdbd/dbhomewdb ${BACKUP_DIR}/backdbd/
cp -rfv /SDServer/uniquenamed/uname ${BACKUP_DIR}/uniquenamed/

zip -r "${ZIP_FILE}" "${BACKUP_DIR}"
chmod 644 ${ZIP_FILE}

rm -rfv ${BACKUP_DIR}

# Número máximo de backups para manter
MAX_BACKUPS=30

# Excluir arquivos mais antigos mantendo os mais recentes
cd $PUBLIC_DIR
ls -tp | grep -v '/$' | grep 'sds-.*\.zip' | tail -n +$((MAX_BACKUPS + 1)) | xargs -I {} rm -- {}


