#!/bin/bash

Help() {
    # Display Help
    echo "Run rsync for iphone DCIM directory."
    echo
    echo "Usage: copy-iphone-photos.sh DCIM_COPY_DESTINATION"
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
DCIM=$(cd $GVFS/*/DCIM && pwd)

echo "Using DCIM path: $DCIM"
# Eclude live photo videos
#rsync --ignore-existing --exclude IMG*.MOV --exclude *.AAE -r $DCIM $1 > ~/DCIM.log
rsync --ignore-existing -r $DCIM $1 &> ~/DCIM.log

echo "Done. See ~/DCIM.log for errors and files which weren't copied."
