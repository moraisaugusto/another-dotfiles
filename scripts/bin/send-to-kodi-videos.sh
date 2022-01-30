#!/bin/bash

#
# Set env variables
#
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

#
# Initialize
#
s=0
e=0
SUMMARY_SUCCESS=""
SUMMARY_FAILURE=""

RSYNC_KODI=/storage/.kodi/addons/virtual.network-tools/bin/rsync
SERVER_KODI=root@192.168.50.239:
#
# Upload all files and folders
#
for FNAME in "$@"
do
    # Upload folder to Kodi
    rsync -Pav -e "ssh -i /home/augusto/.ssh/id_rsa_kodi" --rsync-path=$RSYNC_KODI "$FNAME" $SERVER_KODI/storage/videos
    if [ $? -eq 1 ]; then
        e=$((e + 1))
        SUMMARY_FAILURE="$SUMMARY_FAILURE\n(ERR) Could not send folder $FNAME/ on your Kodi Videos"
        continue
    fi

    SUMMARY_SUCCESS="$SUMMARY_SUCCESS\n$FNAME/"
done

# Notify user
notify-send "Kodi upload finished | $s succeeded | $e failed " "\n$SUMMARY_FAILURE\n$SUMMARY_SUCCESS"
