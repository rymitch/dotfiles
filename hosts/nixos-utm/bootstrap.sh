#!/usr/bin/env bash
set -eux pipefail

parted /dev/vda -- mklabel gpt

parted /dev/vda -- mkpart ESP fat32 1MiB 1025MiB
parted /dev/vda -- mkpart swap linux-swap 1025MiB 9217MiB
parted /dev/vda -- mkpart nixos 9217MiB 100%

parted /dev/vda -- set 1 esp on

mkfs.fat -F 32 -n boot /dev/vda1
mkswap -L swap /dev/vda2
mkfs.ext4 -L nixos /dev/vda3

udevadm settle

mount /dev/disk/by-label/nixos /mnt
swapon /dev/disk/by-label/swap
mkdir -p /mnt/boot
mount /dev/disk/by-label/boot /mnt/boot

nixos-install --flake .#nixos-utm
nixos-enter --root /mnt -c 'passwd rmitchell'
