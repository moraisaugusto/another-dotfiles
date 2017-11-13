#!/usr/bin/bash

PKGS=$(cower -u | awk '{print $2}')
BUILD_DIR="~/.builds"


for i in $PKGS;
do
    echo "Updating: $i"
    cd ${i}
    git reset --hard HEAD
    git clean -d -fx
    git pull origin master
    makepkg -si --noconfirm
    cd ..
done
