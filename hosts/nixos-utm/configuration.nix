{ config, lib, pkgs, home-manager, nvf, loginName, displayName, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  fonts.fontDir.enable = true;

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

  networking.hostName = "nixos-utm";
  networking.networkmanager.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs.nix-ld.enable = true;

  services.openssh = {
    enable = true;
    settings.X11Forwarding = true;
  };

  system.stateVersion = "25.11";

  time.timeZone = "Europe/America/Indianapolis";

  users.users.${loginName} = {
    isNormalUser = true;
    description = "${displayName}";
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      tree
    ];
  };
}

