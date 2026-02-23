{ config, lib, pkgs, home-manager, nvf, ... }:
let
  loginName = "rmitchell";
  displayName = "Ryan Mitchell";
  email = "ryan@mitchell.plus";
  homeDirectory = "/Users/${loginName}";
in {
  environment = {
    variables = {
      EDITOR = "nvim";
      SYSTEMD_EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users."${loginName}" = import ../../home/home.nix {
      inherit pkgs nvf loginName displayName email homeDirectory;
    };
    backupFileExtension = "backup";
  };

  ids.gids.nixbld = 350;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.hostPlatform = "aarch64-darwin";

  programs.zsh.enable = true;

  services.openssh.enable = true;

  system.defaults.dock.autohide = true;
  system.primaryUser = "${loginName}";
  system.stateVersion = 4;

  users.users.${loginName} = {
    name = "${loginName}";
    description = "${displayName}";
    home = "${homeDirectory}";
  };
}
