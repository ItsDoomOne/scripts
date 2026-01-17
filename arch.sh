#!/usr/bin/env bash
# easier Arch install script after partitioning

# install base system
pacstrap -K /mnt --noconfirm base base-devel linux-zen linux-firmware \
    kitty sddm hyprland git btrfs-progs efibootmgr timeshift \
    neovim networkmanager pipewire pipewire-alsa pipewire-pulse \
    pipewire-jack wireplumber reflector fish openssh sudo

# generate fstab
genfstab -U /mnt >> /mnt/etc/fstab

# do some last tinkering
arch-chroot /mnt /bin/bash <<'EOF'
# enable services
systemctl enable sddm
systemctl enable NetworkManager

# clone and install paru from AUR
mkdir -p /tmp/yea
git clone https://aur.archlinux.org/paru.git /tmp/yea
(
  cd /tmp/yea || exit 1
  makepkg -si --noconfirm
  rm -rf /tmp/yea
)
EOF
