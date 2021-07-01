#!/usr/bin/env sh

# Backup Zotero data
date=`date +"%Y%m%d_%H%M%S"`
tmp_dir=$HOME/.tmp
app="zotero"
num_backups=5
notification=1
zotero_dir="${HOME}/.zotero"
backup_file="${tmp_dir}/${app}_${date}.tgz"
cloud_dir="$HOME/Nextcloud/backups/zotero"
basedir=`dirname $zotero_dir`
basename=`basename $zotero_dir`
sucess=false
msg_success="Zotero backup done in ${app}_${date}.tgz"
msg_failed="Zotero backup FAILED"

echo "Backing up Zotero data... $zotero_dir"
cd $basedir && tar -zcf $backup_file $basename && mv $backup_file $cloud_dir && msg=$msg_success || msg=$msg_failed
echo $msg

# backup rotate
num_backups=5
files=($(ls -t ${cloud_dir}/zotero_*))
num_files=${#files[@]}

if [ $num_files -gt $num_backups ] ; then
    for (( i=0; i<$num_backups; i++ )); do unset files[$i] ; done
    rm ${files[@]}
fi

# # Pushover notification
if [ $notification == 1 ] ; then
    source ${HOME}/.secrets
    curl -s \
    --form-string "token=$PUSHOVER_TOKEN" \
    --form-string "user=$PUSHOVER_USER" \
    --form-string "message=$msg" \
    https://api.pushover.net/1/messages.json
fi

