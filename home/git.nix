{ config, lib, pkgs, ... }:
{
  options = {
    mine.user.email = lib.mkOption {
      type = lib.types.str;
      default = "";
    };
    mine.user.name = lib.mkOption {
      type = lib.types.str;
      default = "";
    };
  };

  config.home.packages = [
    pkgs.meld
  ];

  config.programs.delta = {
    enable = true;
  };

  config.programs.git = {
    enable = true;
    package = pkgs.gitFull;
    settings = {
      alias = {
        checokut = "checkout";
        co = "checkout";
        dm = "difftool --dir-diff --no-symlinks";
        fix = "!f() { git commit --fixup :/^$1; }; f";
        l = "log --graph --format=compactgraph --max-count=20";
        la = "log --graph --format=compactgraph --all";
        lf = "log --format=medium";
        lg = "log --graph --format=compactgraph";
        prunetags = "!git tag -l | xargs git tag -d && git fetch -t";
        st = "status -sb";
      };
      color = {
        status = "always";
        branch = "auto";
      };
      core = {
        attributesfile = "~/.config/git/attributes";
        autocrlf = "false";
        fileMode = "false";
        pager = "delta";
        whitespace = "cr-at-eol";
      };
      delta = {
        navigate = "true";
      };
      diff = {
        tool = "meld";
      };
      format = {
        pretty = "compactgraph";
      };
      interactive = {
        diffFilter = "delta --color-only";
      };
      log = {
        date = "local";
      };
      merge = {
        conflictstyle = "zdiff3";
      };
      pretty = {
        compactgraph = "%C(blue)%<(10)%h%C(reset)%C(cyan)%ad%C(reset) %C(green)(%cr)%C(reset)%C(yellow)%d%C(reset)%n%<(10)%x20%C(normal)%s%C(reset) %C(magenta)- %ae%C(reset)";
      };
      push = {
        default = "current";
      };
      rebase = {
        autosquash = "true";
      };
      safe = {
        directory = [ "/etc/nixos" ];
      };
      user = {
        email = "${config.mine.user.email}";
        name = "${config.mine.user.name}";
      };
    };
  };
}
