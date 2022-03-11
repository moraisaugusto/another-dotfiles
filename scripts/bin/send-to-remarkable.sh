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

#
# Upload all files and folders
#
for FNAME in "$@"
do
    # Upload folder to RM
    if [ -d "${FNAME}" ] ; then
        rmapi mkdir "$FNAME"
        if [ $? -eq 1 ]; then
            e=$((e + 1))
            SUMMARY_FAILURE="$SUMMARY_FAILURE\n(ERR) Could not create folder $FNAME/ on your RM"
            continue
        fi

        cd "$FNAME"
        rmapi mput "$FNAME"
        if [ $? -eq 1 ]; then
            e=$((e + 1))
            SUMMARY_FAILURE="$SUMMARY_FAILURE\n(ERR) Could not upload folder $FNAME/ to your RM"
            continue
        fi

        cd ..
        SUMMARY_SUCCESS="$SUMMARY_SUCCESS\n$FNAME/"

    # Upload file to RM
    else
        rmapi put "$FNAME"
        if [ $? -eq 1 ]; then
            e=$((e + 1))
            SUMMARY_FAILURE="$SUMMARY_FAILURE\n(ERR) Could not upload file $FNAME to your RM"
            continue
        fi
        SUMMARY_SUCCESS="$SUMMARY_SUCCESS\n$FNAME"
    fi
    s=$((s + 1))
done

# Notify user
notify-send "RM upload finished | $s succeeded | $e failed " "\n$SUMMARY_FAILURE\n$SUMMARY_SUCCESS"
