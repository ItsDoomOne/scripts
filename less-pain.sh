#!/bin/bash


if [ "$UID" -eq 0 ]; then
    pacman --no-confirm -Syu doas
    touch /etc/doas.conf
    echo "permit setenv {PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin} :wheel" > /etc/doas.conf
else
    echo "it appears you are not root. switch to root to run this script. as you are installing doas, i assume you are the admin and can use su or already have sudo."
fi
