{ config, lib, pkgs, loginName, displayName, ... }:

{
  ids.gids.nixbld = 350;
  nix.settings.experimental-features = "nix-command flakes";

  system.stateVersion = 4;

  system.primaryUser = "${loginName}";

  system.defaults.dock.autohide = true;

  nixpkgs.hostPlatform = "aarch64-darwin";

  users.users.${loginName} = {
    name = "${loginName}";
    description = "${displayName}";
    home = "/Users/${loginName}";
  };

  programs.nix-ld.enable = true;

  environment.systemPackages = [
  ];
}
