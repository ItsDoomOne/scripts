#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

source /etc/os-release
distro_id=${ID,,}
like_id=${ID_LIKE,,}

echo "installing ts"

if [[ $distro_id != "arch" && "$like_id" != *"arch"* ]]; then
    echo "this only works in arch or arch based distros"
    echo "Detected: $distro_id ($like_id)"
    exit 1
fi

echo "you are using an arch based distro, you may proceed."

echo "installing some packages and updating system"
sudo pacman -Syu --needed --noconfirm fish fastfetch steam

TMPDIR="/tmp/shitinstaller"
if [[ -d "$TMPDIR" ]]; then
    echo "deleting old folder"
    sudo rm -rf "$TMPDIR"
fi
mkdir -p "$TMPDIR"

echo "downloading paru"
git clone -q https://aur.archlinux.org/paru.git "$TMPDIR"

echo "building paru"
(
    cd "$TMPDIR" || exit 1
    makepkg -si --noconfirm > /tmp/paru.log 2>&1
)
echo "deleting folder"
rm -rf "$TMPDIR"

echo "installing packages using paru"
if ! paru -Syu --noconfirm proton-ge-custom brave-bin; then
    echo "failed to install shit"
    exit 1
fi

echo "installed successfully"
