#!/bin/bash

os=$1
pi=$2
today=`date +'%y%m%d'`

disk_name () {
    diskutil list | grep 'FDisk..' | awk '/disk/ {print $5;}'
}

backup_filename () {
    if [[ ! -e $(eval echo "$today-$os-$pi*") ]]; then
        if [[ ! -e $(eval echo "$today-$os-$pi-*.gz") ]]; then
            echo "$today-$os-$pi-1.gz"
        else
            new=1
            for f in $(eval echo "$today-$os-$pi-*"); do
                old=$(echo $f | sed -e 's/[[:digit:]]*-[[:alpha:]]*-[[:alpha:]]*-//g' | sed -e 's/.gz//g')
                if [ old > new ]; then
                    new=$old
                fi
                new=$(($new+1))
            done
            echo "$today-$os-$pi-$new.gz"
        fi
    else
        echo "$today-$os-$pi.gz"
    fi
}

backup_disk () {
    sudo dd if=/dev/r$(disk_name) bs=1m | gzip > $(PWD)/$(backup_filename)
}

echo "Backing up into $(backup_filename) ..."
$(backup_disk)
