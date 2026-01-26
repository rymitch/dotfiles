{ config, lib, pkgs, user, ... }:

{
  ids.gids.nixbld = 350;
  nix.settings.experimental-features = "nix-command flakes";

  system.stateVersion = 4;

  system.primaryUser = "${user}";

  system.defaults.dock.autohide = true;

  nixpkgs.hostPlatform = "aarch64-darwin";

  users.users."${user}" = {
    name = "${user}";
    description = "Ryan Mitchell";
    home = "/Users/${user}";
  };

  environment.systemPackages = [
  ];
}
