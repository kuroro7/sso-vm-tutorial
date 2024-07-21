#!/bin/bash

# Diretório onde os backups serão armazenados
BACKUP_DIR="/SDServer/jakarta/webapps/iweb/public"

# Nome do banco de dados
DB_NAME="zx"

# Credenciais do banco de dados
DB_USER="root"
DB_PASS="123456"

# Comando para fazer o backup com a data e hora atuais
mysqldump -u $DB_USER -p$DB_PASS $DB_NAME --routines --triggers --events --single-transaction --quick --lock-tables=false > $BACKUP_DIR/zx-$(date +\%Y-\%m-\%d_\%H-\%M-\%S).sql

# Número máximo de backups para manter
MAX_BACKUPS=30

# Excluir arquivos mais antigos mantendo os mais recentes
cd $BACKUP_DIR
ls -tp | grep -v '/$' | grep 'zx-.*\.sql' | tail -n +$((MAX_BACKUPS + 1)) | xargs -I {} rm -- {}


