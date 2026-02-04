{ config, lib, pkgs, home-manager, loginName, displayName, ... }:

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
    users."${loginName}" = import ../../home.nix {
      inherit pkgs;
      inherit loginName;
      inherit displayName;
      homeDirectory = "/home/${loginName}";
    };
    backupFileExtension = "backup";
  };

  networking.hostName = "nixos-utm";
  networking.networkmanager.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

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

