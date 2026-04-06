#!/usr/bin/bash

PKGS=$(cower -u | awk '{print $2}')
BUILD_DIR="/home/augusto/.builds"


for i in $PKGS;
do
    if [ -d "${BUILD_DIR}/${i}" ]; then
        echo "Updating: $i"
        cd ${BUILD_DIR}/${i}
        git clean -d -fx
        git reset --hard HEAD
        git pull origin master
        makepkg -si --noconfirm
        cd ..
    fi
done
