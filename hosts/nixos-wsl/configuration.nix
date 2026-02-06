{ config, lib, pkgs, home-manager, nvf, displayName, ... }:
let
  loginName = "rjmitchell";
  displayName = "Ryan Mitchell";
  email = "ryan.mitchell@beckman.com";
  homeDirectory = "/home/${loginName}";
in {
  imports =
    [
      (import "${home-manager}/nixos")
    ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users."${loginName}" = import ../../home/home.nix {
      inherit pkgs nvf loginName displayName email homeDirectory;
    };
    backupFileExtension = "backup";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs.nix-ld.enable = true;

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      AllowUsers = ["${loginName}"];
      X11Forwarding = true;
      PermitRootLogin = "no";
    };
  };

  system.stateVersion = "25.11";

  wsl.defaultUser = "${loginName}";
  wsl.enable = true;
}
