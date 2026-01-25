{ config, pkgs, ... } :

{
  home.username = "rmitchell";
  home.homeDirectory = "/home/rmitchell";
  home.packages = with pkgs; [
    cowsay
  ];
  programs.git.enable = true;
  home.stateVersion = "25.11";
}
