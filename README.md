# my-home-manager

## Random links

* https://github.com/Evertras/simple-homemanager
* https://github.com/kaleocheng/nix-dots
* https://github.com/evantravers/dotfiles
* https://github.com/nixos-lima/nixos-lima-config-sample
* https://github.com/dustinlyons/nixos-config
* https://somas.is/notes/organizing-nix-configuration-without-flakes/
* https://krisztianfekete.org/nixos-on-apple-silicon-with-utm/
* https://www.tonybtw.com/tutorial/nixos-from-scratch/

## Run WezTerm on Nix

It is problematic to run OpenGL programs using Nix on a non-NixOS
system. [NixGL](https://github.com/nix-community/nixGL) provides a
solution:

1. `nix shell nixpkgs#wezterm`
2. `nix run --impure github:nix-community/nixGL -- wezterm`

## Use a custom name for a WSL distribution

These instructions can also be used to create more than
one copy of the same WSL distribution:

1. Download the `.wsl` file from the official distribution
   [list](https://github.com/microsoft/WSL/blob/master/distributions/DistributionInfo.json)
2. (The `.wsl` file is a `.tar.gz` file with a different extension.
   Earlier versions of WSL use `.tar.gz`.)
3. Import the distribution into WSL:
   `wsl --import NixOnUbuntu C:\Projects\WSL\NixOnUbuntu C:\Users\RJMITCHELL\Downloads\ubuntu-24.04.3-wsl-amd64.wsl --version 2`
4. Run the distribution: `wsl -d NixOnUbuntu`
5. Create a new user account: `useradd -mG sudo -s /bin/bash rjmitchell`
6. Set the password: `passwd rjmitchell`
7. Configure the default user:
   `echo -e "\n[user]\ndefault=rjmitchell" >>/etc/wsl.conf`
9. Exit the shell: `exit`
10. Restart the distribution: `wsl --terminate NixOnUbuntu`
11. Run the distribution: `wsl -d NixOnUbuntu`

## Install NixOS on WSL

* [Instructions](https://nix-community.github.io/NixOS-WSL/install.html)

## Install a root certificate on Ubuntu

1. `sudo apt install ca-certificates`
2. `sudo cp Root-CA.crt /usr/local/share/ca-certificates/`
3. `sudo update-ca-certificates`
