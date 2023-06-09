#!/bin/bash

# Unmount file systems
umount /mnt/stratis/fs1
umount /mnt/stratis/snap1
umount /dev/stratis/strpool/strfs
umount /dev/stratis/strpool/strsnap

# Remove entry from /etc/fstab
sed -i '/\/dev\/stratis\/pool1\/fs1/d' /etc/fstab
sed -i '/\/dev\/stratis\/strpool\/strfs/d' /etc/fstab

# Destroy file systems
stratis filesystem destroy pool1 fs1
stratis fs destroy pool1 snap1
stratis filesystem destroy strpool strfs
stratis filesystem destroy strpool strsnap

# Destroy pool
stratis pool destroy pool1
stratis pool destroy strpool

# Unmount the mount point
umount /fs
umount /stratis

# Remove the mount point
rmdir /fs
rm -rf /stratis

# Wipe file system signature on /dev/sdc
wipefs -a /dev/sdc
wipefs -a /dev/sda
wipefs -a /dev/sdb

# Print confirmation
echo "Stratis pool 'pool1', its file systems, the mount point '/fs', the entry in /etc/fstab, and the file system signature on /dev/sdc have been revoked."
