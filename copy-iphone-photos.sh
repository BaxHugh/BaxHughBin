#!/bin/bash

Help() {
    # Display Help
    echo "Run rsync for iphone photo directory."
    echo
    echo "Usage: copy-iphone-photos.sh DCIM_COPY_DESTINATION"
    echo "Assumes the iphone photo directory can be matched to '/run/user/1000/gvfs/gphoto2:host=Apple_Inc*'"
}

# Get the options
while getopts ":h" option; do
   case $option in
      h) # display Help
         Help
         exit;;
   esac
done

GVFS="/run/user/1000/gvfs"
# This assumes there's only one device at GVFS
IPHONE_PHOTOS_PATH=$(cd $GVFS/gphoto2:host=Apple_Inc* && pwd)

echo "Using path: $IPHONE_PHOTOS_PATH"
# Eclude live photo videos
#rsync --ignore-existing --exclude IMG*.MOV --exclude *.AAE -r $IPHONE_PHOTOS_PATH $1 > ~/iphone-photos-copy.log
rsync --ignore-existing -r $IPHONE_PHOTOS_PATH/* $1 &> ~/iphone-photos-copy.log
cat ~/iphone-photos-copy.log

echo "Done. See ~/iphone-photos-copy.log for errors and files which weren't copied."
