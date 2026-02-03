{ config, lib, pkgs, home-manager, nixos-lima, nvf, loginName, displayName, modulesPath, ... }:
{
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
    nixos-lima.nixosModules.lima
  ];

  boot.extraModulePackages = [ ];
  boot.initrd.availableKernelModules = [ "virtio_pci" "xhci_pci" "usbhid" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [ "console=tty0" ];
  boot.loader.grub = {
    device = "nodev";
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  fileSystems."/" = {
    device = "/dev/vda2";
    fsType = "ext4";
  };
  fileSystems."/boot" = {
    device = "/dev/vda1";
    fsType = "vfat";
    options = [ "fmask=0022" "dmask=0022" ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users."${loginName}" = import ../../home/home.nix {
      inherit pkgs;
      inherit nvf;
      inherit loginName;
      inherit displayName;
      homeDirectory = "/home/${loginName}";
    };
    backupFileExtension = "backup";
  };

  networking.hostName = "nixsample";
  networking.networkmanager.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";

  programs.nix-ld.enable = true;

  security = {
    sudo.wheelNeedsPassword = false;
  };

  services.lima.enable = true;
  services.openssh.enable = true;

  swapDevices = [ ];

  system.stateVersion = "25.11";

  users.users.${loginName} = {
    isNormalUser = true;
    description = "${displayName}";
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      tree
    ];
  };
}
