#!/bin/bash

# Overwrite partition table for /dev/sda
dd if=/dev/zero of=/dev/sda bs=512 count=1 conv=notrunc

# Overwrite partition table for /dev/sdb
dd if=/dev/zero of=/dev/sdb bs=512 count=1 conv=notrunc

# Overwrite partition table for /dev/sdc
dd if=/dev/zero of=/dev/sdc bs=512 count=1 conv=notrunc

# Print confirmation
echo "Partition tables reset for /dev/sda, /dev/sdb, and /dev/sdc."
