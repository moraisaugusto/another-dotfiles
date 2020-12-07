#!/usr/bin/env sh

# Backup Zotero data
date=`date +"%Y%m%d_%H%M%S"`
tmp_dir=$HOME/.tmp

app="zotero"
zotero_dir="${HOME}/.zotero"
backup_file="${tmp_dir}/${app}_${date}.tgz"
cloud_dir="$HOME/Nextcloud/backups/zotero"

echo "Backing up Zotero data... $zotero_dir"
basedir=`dirname $zotero_dir`
basename=`basename $zotero_dir`
notification=1

msg_success="Zotero backup done on $date"
msg_failed="Zotero backup FAILED"

sucess=false
cd $basedir && tar -zcf $backup_file $basename && mv $backup_file $cloud_dir && msg=$msg_success || msg=$msg_failed
echo $msg

# Pushover notification
if [ $notification == 1 ] ; then
    source ${HOME}/.zshSecrets
    curl -s \
    --form-string "token=$PUSHOVER_TOKEN" \
    --form-string "user=$PUSHOVER_USER" \
    --form-string "message=$msg" \
    https://api.pushover.net/1/messages.json
fi

