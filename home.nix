{ config, pkgs, ... } :

{
  home.username = "rmitchell";
  home.homeDirectory = "/home/rmitchell";
  programs.git.enable = true;
  home.stateVersion = "25.11";
}
