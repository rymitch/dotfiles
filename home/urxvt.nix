{ config, lib, pkgs, ... }:
{
  config.home.packages = [
    pkgs.nerd-fonts.meslo-lg
  ];

  config.programs.urxvt = {
    enable = true;
    fonts = [
      "xft:MesloLGS Nerd Font Mono:style=Regular:size=10"
    ];
  };
}
