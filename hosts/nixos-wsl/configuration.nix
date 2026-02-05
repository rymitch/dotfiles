{ config, lib, pkgs, home-manager, loginName, displayName, ... }:

{
  imports =
    [
      (import "${home-manager}/nixos")
    ];

  system.stateVersion = "25.11";
  wsl.defaultUser = "${loginName}";
  wsl.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users."${loginName}" = import ../../home/home.nix {
      inherit pkgs;
      inherit loginName;
      inherit displayName;
      homeDirectory = "/home/${loginName}";
    };
    backupFileExtension = "backup";
  };

  programs.nix-ld.enable = true;

  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = true;
      AllowUsers = ["${loginName}"];
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "no";
    };
  };
}
