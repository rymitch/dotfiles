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
* https://github.com/jack-thesparrow/schrovimger

## Create a NixOS virtual machine on Hyper-V

1. Use the Hyper-V user interface to create a new VM:
   1. Use the defaults, unless otherwise specified.
   2. Pick "Generation 2"
   3. Configure the RAM and storage size as needed.
   4. Pick "Install an operating system from a bootable image file" and select
      the "nixos-minimal" ISO file.
2. In the VM settings:
   1. Under "Security" uncheck "Enable Secure Boot".
   2. Under "Checkpoints" uncheck "Enable checkpoints".
   3. Click "OK" to save and close the VM settings.
3. Start the VM and wait for a bash prompt to appear.
4. Bootstrap the NixOS installation:
   1. `git clone https://github.com/rymitch/dotfiles.git -b nix`
   2. `cd dotfiles`
   3. `sudo sh hosts/nixos-hv/bootstrap.sh`
   4. `sudo shutdown -h now`
5. In the Hyper-V settings for the VM, delete the DVD drive where the ISO image
   is attached.
6. Start the VM. NixOS is ready for use.

To build and activate a new configuration:

1. `git clone git@github.com/rymitch/dotfiles.git -b nix`
2. `cd dotfiles`
3. `sudo nixos-rebuild switch --flake .#nixos-hv`

## Create a NixOS virtual machine on Lima

1. Bootstrap the NixOS installation:
   1. `sudo sh hosts/nixos-utm/bootstrap.sh`

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
   2. Under "Network" pick "Emulated VLAN". This enables the "Port Forward"
      section.
   3. Under "Port Forward" click "New". Enter "22" in the second box, and
      "2222" in the fourth box. Click "Save".
   4. Click "Save" to close the VM settings.
3. Start the VM and wait for a bash prompt to appear.
4. Bootstrap the NixOS installation:
   1. `git clone https://github.com/rymitch/dotfiles.git -b nix`
   2. `cd dotfiles`
   3. `sudo sh hosts/nixos-utm/bootstrap.sh`
   4. `sudo shutdown -h now`
5. In the UTM settings for the VM, delete the USB drive where the ISO image is
   attached.
6. Start the VM. NixOS is ready for use.

To build and activate a new configuration:

1. `git clone git@github.com/rymitch/dotfiles.git -b nix`
2. `cd dotfiles`
3. `sudo nixos-rebuild switch --flake .#nixos-utm`

## Create a Nix-based macOS virtual machine on UTM

1. Use the UTM user interface to create a new VM:
   1. Pick "Virtualize"
   2. Pick "macOS 12+"
   3. Use the defaults for the remaining steps, configuring the RAM and storage
      as needed.
2. Start the VM and wait for the macOS install to complete.
3. Open a terminal and bootstrap the Nix installation:
   1. `curl -sSf -L https://install.lix.systems/lix | sh -s -- install`
   2. `git clone https://github.com/rymitch/dotfiles.git -b nix`
   3. If prompted, install the developer tools.
   4. To refresh the shell environment, close the existing terminal and open a
      new terminal.
   5. `git clone https://github.com/rymitch/dotfiles.git -b nix`
   6. `cd dotfiles`
   7. `sudo nix run nix-darwin/master#darwin-rebuild -- switch --flake .#nix-mac`
   8. `sudo shutdown -h now`
4. To refresh the shell environment, close the existing terminal and open a new
   terminal.

To build and activate a new configuration:

1. `cd dotfiles`
2. `sudo darwin-rebuild switch --flake .#nix-mac`

## Create a NixOS virtual machine on WSL

1. Download `nixos.wsl` for the latest
   [release](https://github.com/nix-community/NixOS-WSL/releases/latest).
2. Create a new NixOS distribution:
   `wsl --import NixOS /c/Projects/Nix/NixOS nixos.wsl --version 2`
3. Enter the new NixOS distribution: `wsl -d NixOS`
4. Bootstrap the NixOS installation:
   1. `cd ~`
   2. `nix-shell -p git`
   3. `git clone https://github.com/rymitch/dotfiles.git -b nix`
   4. `cd dotfiles`
   5. `sudo nixos-rebuild boot --flake .#nixos-wsl`
   6. Stop the NixOS instance:
      1. Exit the Nix shell: `exit`
      2. Exit the WSL shell: `exit`
      3. Stop the WSL instance: `wsl -t NixOS`
   7. Start a shell inside NixOS and immediately exit it to apply the new
      generation: `wsl -d NixOS --user root exit`
   8. Stop the NixOS instance again: `wsl -t NixOS`
5. Open the WSL shell. NixOS is ready for use.

To build and activate a new configuration:

1. `git clone git@github.com/rymitch/dotfiles.git -b nix`
2. `cd dotfiles`
3. `sudo nixos-rebuild switch --flake .#nixos-wsl`

For more detail, refer to the NixOS-WSL
[instructions](https://nix-community.github.io/NixOS-WSL/install.html).

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

## Install a root certificate on Ubuntu

1. `sudo apt install ca-certificates`
2. `sudo cp Root-CA.crt /usr/local/share/ca-certificates/`
3. `sudo update-ca-certificates`
