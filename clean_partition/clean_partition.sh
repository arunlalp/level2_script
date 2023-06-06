#!/bin/bash

# Unmount any mounted partitions
umount /dev/myvg/extlv
umount /dev/myvg/xfslv
umount /dev/myvg/mylv
umount /dev/wgroup/wshare
umount /dev/wgroup/lv1
umount /dev/datastore/database

# Deactivate logical volumes
lvchange -an /dev/myvg/extlv
lvchange -an /dev/myvg/xfslv
lvchange -an /dev/myvg/mylv
lvchange -an /dev/wgroup/wshare
lvchange -an /dev/wgroup/lv1
lvchange -an /dev/datastore/database

# Remove logical volumes
lvremove -f /dev/myvg/extlv
lvremove -f /dev/myvg/xfslv
lvremove -f /dev/myvg/mylv
lvremove -f /dev/wgroup/wshare
lvremove -f /dev/wgroup/lv1
lvremove -f /dev/datastore/database

# Remove volume group
vgremove -f myvg
vgremove -f wgroup
vgremove -f datastore

# Remove physical volume
pvremove -f /dev/sda
pvremove -f /dev/sdc1
pvremove -f /dev/sdb2

# Overwrite partition table for /dev/sda
dd if=/dev/zero of=/dev/sda bs=512 count=1 conv=notrunc

# Print confirmation
echo "Partition table and LVM volumes cleaned on /dev/sda."
