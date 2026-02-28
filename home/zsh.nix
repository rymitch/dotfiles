{ config, lib, pkgs, ... }:
{
  config.home.packages = [
    pkgs.fzf
  ];

  config.home.file.".p10k.zsh".text = builtins.readFile ./p10k.zsh;

  config.programs.zsh = {
    enable = true;

    history = {
      ignoreAllDups = true;
      ignorePatterns = [
        "cls"
        "cp *"
        "dir"
        "exit"
        "fg"
        "ls"
        "pkill *"
        "rm *"
      ];
    };

    initContent = ''
      bindkey -v
      bindkey '^F' end-of-line
      bindkey '^R' fzf_history_search
      source ~/.p10k.zsh
    '';

    zplug = {
      enable = true;
      plugins = [
        { name = "agkozak/zsh-z"; }
        { name = "joshskidmore/zsh-fzf-history-search"; }
        { name = "romkatv/powerlevel10k"; tags = [ "as:theme" "depth:1" ]; }
        { name = "unixorn/fzf-zsh-plugin"; }
        { name = "zsh-users/zsh-autosuggestions"; }
        { name = "zsh-users/zsh-completions"; }
        { name = "zsh-users/zsh-syntax-highlighting"; }
      ];
    };
  };
}
