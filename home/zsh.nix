{ config, lib, pkgs, ... }:
{
  config.programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    history = {
      ignorePatterns = [
        "cls"
        "dir"
        "exit"
        "fg"
        "ls"
      ];
    };
  };
}
