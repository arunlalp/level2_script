#!/bin/bash

# Unmount file systems
umount /ext4fs
umount /xfsfs

# Remove entries from /etc/fstab
sed -i '/\/dev\/myvg\/mylv/d' /etc/fstab
sed -i '/\/dev\/vgbook\/lvbook/d' /etc/fstab

# Remove mount points
rmdir /ext4fs
rmdir /xfsfs

# Deactivate logical volumes
lvchange -an /dev/myvg/mylv
lvchange -an /dev/vgbook/lvbook

# Remove logical volumes
lvremove -f /dev/myvg/mylv
lvremove -f /dev/vgbook/lvbook

# Remove volume groups
vgremove -f myvg
vgremove -f vgbook

# Remove physical volumes
pvremove -f /dev/sda1
pvremove -f /dev/sdb1

# Remove partitions
parted /dev/sda rm 1
parted /dev/sdb rm 1

# Wipe partition signatures
wipefs -a /dev/sda
wipefs -a /dev/sdb

# Print confirmation
echo "All previous configurations on /dev/sda and /dev/sdb have been revoked and partitions wiped."
