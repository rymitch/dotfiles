{ pkgs, nvf, loginName, displayName, email, homeDirectory, ... } :

{
  imports = [
    ./ckcolor.nix
    ./git.nix
    ./jq.nix
    ./tmux.nix
    ./uv.nix
    ./wezterm.nix
    ./zsh.nix
  ];

  home = {
    packages = with pkgs; [
      coreutils-full
      cowsay
      hello
      meld
      nerd-fonts.meslo-lg
      xorg.xrdb
    ];

    username = "${loginName}";
    homeDirectory = "${homeDirectory}";
    stateVersion = "25.11";
  };

  mine.user.email = "${email}";
  mine.user.name = "${displayName}";

  fonts.fontconfig.enable = true;

  home.shellAliases = {
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

  programs.bash = {
    enable = true;
    historyIgnore = [
      "cls"
      "dir"
      "exit"
      "fg"
      "ls"
    ];
  };

  programs.delta = {
    enable = true;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  programs.ripgrep = {
    enable = true;
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks."*" = {
      addKeysToAgent = "yes";
    };
  };

  services.ssh-agent = {
    enable = true;
  };

  programs.urxvt = {
    enable = true;
    fonts = [
      "xft:MesloLGS Nerd Font Mono:style=Regular:size=10"
    ];
  };
}
