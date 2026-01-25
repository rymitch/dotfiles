{ config, lib, pkgs, ... }:

{
  imports = [
    <nixos-wsl/modules>
  ];

  wsl.enable = true;
  wsl.defaultUser = "nixos";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

  # Add the Beckman root certificate as a trusted root
  # certificate. This is necessary when running NixOS
  # on a domain computer (using eithwer WSL2 or a VM).
  security.pki.certificateFiles = [
    ./BEC-Root-CA.crt
  ];

  # Enable flakes.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  #boot.initrd.availableKernelModules = [ "virtio_pci" "xhci_pci" "usbhid" ];
  #boot.initrd.kernelModules = [ ];
  #boot.kernelModules = [ ];
  #boot.extraModulePackages = [ ];
  #boot.kernelPackages = pkgs.linuxPackages_latest;
  #
  #fileSystems."/" =
  #  { device = "/dev/vda2";
  #    fsType = "ext4";
  #  };
  #
  #fileSystems."/boot" =
  #  { device = "/dev/vda1";
  #    fsType = "vfat";
  #    options = [ "fmask=0022" "dmask=0022" ];
  #  };
  #
  #swapDevices = [ ];
  #
  #nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
  #
  #boot.loader.grub = {
  #  device = "nodev";
  #  efiSupport = true;
  #  efiInstallAsRemovable = true;
  #};
  #
  #boot.kernelParams = [ "console=tty0" ];
  #
  #networking.hostName = "nixsample";
  #
  #networking.networkmanager.enable = true;
  #
  #services.openssh.enable = true;
  #
  #security = {
  #  sudo.wheelNeedsPassword = false;
  #};
  #
  #environment.systemPackages = with pkgs; [
  #  home-manager
  #];
}
