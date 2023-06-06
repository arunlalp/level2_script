#!/bin/bash

# Prompt for confirmation before proceeding
read -p "Warning: The existing disk label on /dev/sda will be destroyed and all data on this disk will be lost. Do you want to continue? (Yes/No): " answer

# Check user's answer and proceed if "Yes" is entered
if [[ $answer == "Yes" ]]; then

  # Create a 500MB partition using fdisk
  echo -e "o\nn\np\n\n\n+500M\nw" | fdisk /dev/sda
  
  # Wait for the partition to be created
  sleep 2
  
  # Set up LVM
  pvcreate /dev/sda1
  vgcreate myvg /dev/sda1
  
  # Create a logical volume of 300MB
  lvcreate -L 300M -n mylv myvg

  # Format the partition with ext4
  mkfs.ext4 /dev/myvg/mylv
  
  # Create the directory for mounting if it doesn't exist
  mkdir -p /resize_dir
  
  # Mount the logical volume
  mount /dev/myvg/mylv /resize_dir
  
  # Update /etc/fstab for permanent mounting
  echo '/dev/myvg/mylv   /resize_dir   ext4   defaults   0 0' >> /etc/fstab
  
  # Print confirmation
  echo "Partition created, filesystem formatted, LVM configured, logical volume created, and mounted permanently."

else
  echo "Script execution canceled."
fi
