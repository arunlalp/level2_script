#!/bin/bash

# Unmount file systems
umount /mnt/stratis/fs1
umount /mnt/stratis/snap1

# Remove entry from /etc/fstab
sed -i '/\/dev\/stratis\/pool1\/fs1/d' /etc/fstab

# Destroy file systems
stratis filesystem destroy pool1 fs1
stratis fs destroy pool1 snap1

# Destroy pool
stratis pool destroy pool1

# Unmount the mount point
umount /fs

# Remove the mount point
rmdir /fs

# Wipe file system signature on /dev/sdc
wipefs -a /dev/sdc

# Print confirmation
echo "Stratis pool 'pool1', its file systems, the mount point '/fs', the entry in /etc/fstab, and the file system signature on /dev/sdc have been revoked."
