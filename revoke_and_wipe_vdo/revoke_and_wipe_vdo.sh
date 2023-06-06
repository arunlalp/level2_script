#!/bin/bash

# Unmount and remove the VDO volume
umount /vdo-volume
umount /vdo
vdo remove --name vdo-vol1
vdo remove --name myvdo
rm -r /vdo-volume
rm -r /vdo

# Stop and disable the VDO service
systemctl stop vdo
systemctl disable vdo

# Remove the VDO packages
dnf remove -y kmod-kvdo* vdo

# Wipe the underlying device
wipefs -a /dev/sdc

# Remove VDO configurations from /etc/fstab
sed -i '/vdo-vol1/d' /etc/fstab
sed -i '/myvdo/d' /etc/fstab

# Print confirmation
echo "VDO process revoked successfully. VDO volume on /dev/sdc wiped and ready for a fresh setup."
