#!/bin/bash

file_name=$1
disk_name=$2

unmount_disk () {
    sudo diskutil unmount /dev/$1s1
}

flash_disk () {
    gzip -dc $(PWD)/$1 | sudo dd of=/dev/r$2 bs=1m
}

echo "Flashing $file_name to SD card ..."
$(unmount_disk $disk_name)
$(flash_disk $file_name $disk_name)

