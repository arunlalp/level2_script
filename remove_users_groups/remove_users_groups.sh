#!/bin/bash

# Define the exception users
EXCEPTION_USERS=("arun" "user30")

# Remove users
for user in $(awk -F: '$3 > 1000 {print $1}' /etc/passwd); do
    if [[ ! " ${EXCEPTION_USERS[@]} " =~ " ${user} " ]]; then
        userdel -r "${user}"
    fi
done

# Remove groups
for group in $(awk -F: '$3 > 1000 {print $1}' /etc/group); do
    if [[ ! " ${EXCEPTION_USERS[@]} " =~ " ${group} " ]]; then
        groupdel "${group}"
    fi
done

# Print confirmation
echo "Users and groups above UID/GID 1000, except 'arun' and 'user30', have been removed."
