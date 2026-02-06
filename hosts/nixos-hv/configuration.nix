{ config, lib, pkgs, home-manager, nvf, ... }:
let
  loginName = "rjmitchell";
  displayName = "Ryan Mitchell";
  email = "ryan.mitchell@beckman.com";
  homeDirectory = "/home/${loginName}";
in {
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
      inherit pkgs nvf loginName displayName email homeDirectory;
    };
    backupFileExtension = "backup";
  };

  networking.hostName = "nixos-hv";
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
