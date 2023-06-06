#!/bin/bash

# Disable swap
swapoff /dev/sdb1

# Remove the swap partition using parted
parted /dev/sdb mklabel msdos rm 1

# Clear the swap signature
wipefs -a /dev/sdb1

# Print confirmation
echo "Swap partition on /dev/sdb1 has been cleaned."
