#!/usr/bin/env bash
set -eux

limactl start --yes --plain https://raw.githubusercontent.com/nixos-lima/nixos-lima/master/nixos.yaml
limactl shell nixos -- sudo git clone -b nix-working https://github.com/rymitch/dotfiles.git /etc/nixos
limactl shell nixos -- sudo nixos-rebuild boot --flake /etc/nixos#nixsample-aarch64
sleep 0.1
limactl stop nixos
limactl start nixos
