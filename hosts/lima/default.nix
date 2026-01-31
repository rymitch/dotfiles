{ config, lib, pkgs, loginName, displayName, modulesPath, nixos-lima, ... }:
{
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
    nixos-lima.nixosModules.lima
  ];

  services.lima.enable = true;

  boot.initrd.availableKernelModules = [ "virtio_pci" "xhci_pci" "usbhid" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];
  boot.kernelPackages = pkgs.linuxPackages_latest;

  fileSystems."/" =
    { device = "/dev/vda2";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/vda1";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  users.users.${loginName} = {
    isNormalUser = true;
    description = "${displayName}"
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      tree
    ];
  };


  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";

  boot.loader.grub = {
    device = "nodev";
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  boot.kernelParams = [ "console=tty0" ];

  networking.hostName = "nixsample";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.networkmanager.enable = true;

  services.openssh.enable = true;

  security = {
    sudo.wheelNeedsPassword = false;
  };

  environment.systemPackages = with pkgs; [
    home-manager
  ];

  # This value determines the NixOS release from which default
  # settings for stateful data were taken. Leave it at your first
  # install's release unless you know what you're doing.
  system.stateVersion = "25.11";
}
