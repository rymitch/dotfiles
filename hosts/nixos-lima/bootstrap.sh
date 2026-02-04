#!/usr/bin/env bash
set -eux

limactl start --yes --plain --set '.user.name = "rmitchell"' https://raw.githubusercontent.com/nixos-lima/nixos-lima/master/nixos.yaml
limactl shell nixos -- sudo git clone -b nix https://github.com/rymitch/dotfiles.git /etc/nixos
limactl shell nixos -- sudo nixos-rebuild boot --flake /etc/nixos#nixos-lima
sleep 0.1
limactl stop nixos
limactl start nixos
