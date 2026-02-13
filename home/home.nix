{ pkgs, nvf, loginName, displayName, email, homeDirectory, ... } :

{
  imports = [
    ./bash.nix
    ./ckcolor.nix
    ./git.nix
    ./jq.nix
    ./ssh.nix
    ./tmux.nix
    ./urxvt.nix
    ./uv.nix
    ./wezterm.nix
    ./zsh.nix
  ];

  fonts.fontconfig.enable = true;

  home = {
    packages = with pkgs; [
      coreutils-full
    ];

    shellAliases = {
      bc = "bc -l";
      clear = "printf \"\\033c\"";
      cls = "printf \"\\033c\"";
      df = "df -hx \"squashfs\"";
      dir = "LC_COLLATE=C ls -ahlN --color=auto --group-directories-first";
      du = "du -h";
      grep = "grep --color=auto";
      ls = "LC_COLLATE=C ls -hN --color=auto --group-directories-first";
      myip = "curl ifconfig.me";
    };

    username = "${loginName}";
    homeDirectory = "${homeDirectory}";
    stateVersion = "25.11";
  };

  mine.user.email = "${email}";
  mine.user.name = "${displayName}";

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  programs.ripgrep = {
    enable = true;
  };
}
