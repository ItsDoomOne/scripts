#!/bin/bash

sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key 3056513887B78AEB
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' --noconfirm
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' --noconfirm
echo "[chaotic-aur]"  | sudo bash -c 'cat >> /etc/pacman.conf'
echo "Include = /etc/pacman.d/chaotic-mirrorlist"  | sudo bash -c 'cat >> /etc/pacman.conf'
sudo pacman -Syu
