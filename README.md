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
* https://gist.github.com/samelie/db65e7decbfdb74d748d44860840b51f

## Create a NixOS virtual machine on Hyper-V

1. Use the Hyper-V user interface to create a new VM:
   1. Use the defaults, unless otherwise specified.
   2. Pick "Generation 2"
   3. Configure the RAM and storage size as needed.
   4. Pick "Install an operating system from a bootable image file" and select the "nixos-minimal" ISO file.
2. In the VM settings:
   1. Under "Security" uncheck "Enable Secure Boot".
   2. Under "Checkpoints" uncheck "Enable checkpoints".
   3. Click "OK" to save and close the VM settings.
3. Start the VM and wait for a bash prompt to appear.
4. Bootstrap the NixOS installation:
   1. `git clone https://github.com/rymitch/dotfiles.git -b nix`
   2. `cd dotfiles`
   3. `sudo sh hosts/nixos-hv/format-drive.sh`
   4. `sudo shutdown -h now`
5. In the Hyper-V settings for the VM, delete the DVD drive where the ISO image is attached.
6. Start the VM.

## Create a NixOS virtual machine on UTM

1. Use the UTM user interface to create a new VM:
   1. Pick "Virtualize"
   2. Pick "Other"
   3. Configure the RAM as needed.
   4. Select the "nixos-minimal" ISO file.
   5. Configure the storage as needed.
   6. Use the defaults for the remaining steps.
   7. On the last page, check "Open VM Settings" and click "Save".
2. In the VM settings:
   1. Under "Display" pick "virtio-gpu-gl-pci".
   2. Under "Network" pick "Emulated VLAN".
   3. Under "Port Forward" click "New". Enter "22" in the second box, and "2222" in the fourth box. Click "Save".
   4. Click "Save" to close the VM settings.
3. Start the VM and wait for a bash prompt to appear.
4. Bootstrap the NixOS installation:
   1. `git clone https://github.com/rymitch/dotfiles.git -b nix`
   2. `cd dotfiles`
   3. `sudo sh hosts/nixos-utm/format-drive.sh`
   4. `sudo shutdown -h now`
5. In the UTM settings for the VM, delete the USB drive where the ISO image is attached.
6. Start the VM.

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
