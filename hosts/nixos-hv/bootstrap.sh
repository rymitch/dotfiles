#!/usr/bin/env bash
set -eux pipefail

parted /dev/sda -- mklabel gpt

parted /dev/sda -- mkpart ESP fat32 1MiB 1025MiB
parted /dev/sda -- mkpart swap linux-swap 1025MiB 9217MiB
parted /dev/sda -- mkpart nixos 9217MiB 100%

parted /dev/sda -- set 1 esp on

mkfs.fat -F 32 -n boot /dev/sda1
mkswap -L swap /dev/sda2
mkfs.ext4 -L nixos /dev/sda3

udevadm settle

mount /dev/disk/by-label/nixos /mnt
swapon /dev/disk/by-label/swap
mkdir -p /mnt/boot
mount /dev/disk/by-label/boot /mnt/boot

nixos-install --flake .#nixos-hv
nixos-enter --root /mnt -c 'passwd rjmitchell'
