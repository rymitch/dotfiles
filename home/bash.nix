{ config, lib, pkgs, ... }:
{
  config.programs.bash = {
    enable = true;
    historyIgnore = [
      "cls"
      "dir"
      "exit"
      "fg"
      "ls"
    ];
  };
}
