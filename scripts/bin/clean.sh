#!/bin/bash

DIR=~/.builds
# remove all tar.xz ,deb and tar.gz files
find $DIR \( -name \*.tar.gz -o -name \*.deb -o -name \*.tar.xz \) -exec rm -rf {} \; 2>/dev/null

# remove all src directories until the second level 
find $DIR -type d -name "src" -maxdepth 2 -exec rm -rf {} \; 2>/dev/null

# remove all pkg directories until the second level 
find $DIR -type d -name "pkg" -maxdepth 2 -exec rm -rf {} \; 2>/dev/null
