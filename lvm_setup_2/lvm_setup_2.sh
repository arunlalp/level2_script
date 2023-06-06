#!/bin/bash

# Create partition on /dev/sda
parted /dev/sda mklabel msdos mkpart primary ext4 0% 1G

# Create partition on /dev/sdb
parted /dev/sdb mklabel msdos mkpart primary ext4 0% 1G

# Create physical volumes
pvcreate /dev/sda1
pvcreate /dev/sdb1

# Create volume groups
vgcreate myvg /dev/sda1
vgcreate vgbook /dev/sdb1

# Create logical volumes
lvcreate -L 400M -n mylv myvg
lvcreate -L 400M -n lvbook vgbook

# Format logical volumes
mkfs.ext4 /dev/myvg/mylv
mkfs.xfs /dev/vgbook/lvbook

# Create mount points
mkdir /ext4fs
mkdir /xfsfs

# Update /etc/fstab for ext4fs
echo "/dev/myvg/mylv  /ext4fs  ext4  defaults  0  0" >> /etc/fstab

# Update /etc/fstab for xfsfs
echo "/dev/vgbook/lvbook  /xfsfs  xfs  defaults  0  0" >> /etc/fstab

# Mount file systems
mount -a

# Print confirmation
echo "Partition, volume groups, logical volumes, file systems, mount points, and /etc/fstab have been configured."
