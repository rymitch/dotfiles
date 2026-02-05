{ pkgs, loginName, displayName, homeDirectory, ... } :

{
  imports = [
    ./ckcolor.nix
  ];

  home = {
    packages = with pkgs; [
      cowsay
      hello
      nerd-fonts.meslo-lg
      xorg.xrdb
    ];

    username = "${loginName}";
    homeDirectory = "${homeDirectory}";
    stateVersion = "25.11";
  };

  fonts.fontconfig.enable = true;

  programs.bash = {
    enable = true;
    historyIgnore = [
      "dir"
      "exit"
      "fg"
      "ls"
    ];
    shellAliases = {
      ls = "LC_COLLATE=C ls -hN --color=auto --group-directories-first";
      dir = "LC_COLLATE=C ls -ahlN --color=auto --group-directories-first";
    };
  };

  programs.delta = {
    enable = true;
  };

  programs.git = {
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
        light = "false";
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
        name = "Ryan Mitchell";
        email = "ryan@mitchell.plus";
      };
    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local wezterm = require 'wezterm'
      local act = wezterm.action
      local config = wezterm.config_builder()

      -- Color scheme (based on Alabaster)
      config.colors = {
        background = '#F7F7F7',
        foreground = '#434343',

        cursor_fg = '#F7F7F7',
        cursor_bg = '#434343',
        cursor_border = '#434343',
        compose_cursor = 'orange',

        selection_fg = 'black',
        selection_bg = '#fffacd',
        scrollbar_thumb = '#222222',
        split = '#444444',

        ansi = {
          '#000000',
          '#AA3731',
          '#448C27',
          '#CB9000',
          '#325CC0',
          '#7A3E9D',
          '#0083B2',
          '#BBBBBB',
        },
        brights = {
          '#777777',
          '#F05050',
          '#60CB00',
          '#FFBC5D',
          '#007ACC',
          '#E64CE6',
          '#00AACB',
          '#FFFFFF',
        },

        copy_mode_active_highlight_bg = { Color = '#000000' },
        copy_mode_active_highlight_fg = { AnsiColor = 'Black' },
        copy_mode_inactive_highlight_bg = { Color = '#52ad70' },
        copy_mode_inactive_highlight_fg = { AnsiColor = 'White' },

        quick_select_label_bg = { Color = 'peru' },
        quick_select_label_fg = { Color = '#ffffff' },
        quick_select_match_bg = { AnsiColor = 'Navy' },
        quick_select_match_fg = { Color = '#ffffff' },

        tab_bar = {
          background = '#434343',
          active_tab = {
            bg_color = '#f8f8f2',
            fg_color = '#434343',
            intensity = 'Bold',
          },
          inactive_tab = {
            fg_color = '#f8f8f2',
            bg_color = '#434343',
          },
          inactive_tab_hover = {
            bg_color = '#f8f8f2',
            fg_color = '#434343',
            italic = true,
          },
          new_tab = {
            fg_color = '#f8f8f2',
            bg_color = '#434343',
          },
          new_tab_hover = {
            bg_color = '#f8f8f2',
            fg_color = '#434343',
            italic = true,
          },
        }
      }

      -- Window appearance
      config.font = wezterm.font { family = 'MesloLGS Nerd Font Mono', weight = 'Regular' }
      config.font_size = 10.0
      config.window_padding = { bottom = 0, left = 0, right = 0, top = 0  }

      -- Tab bar
      config.hide_tab_bar_if_only_one_tab = true
      config.switch_to_last_active_tab_when_closing_tab = true
      config.tab_max_width = 32
      config.tab_bar_at_bottom = true
      config.use_fancy_tab_bar = false

      return config
    '';

  };

  programs.urxvt = {
    enable = true;
    fonts = [
      "xft:MesloLGS Nerd Font Mono:style=Regular:size=10"
    ];
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

  programs.tmux = {
    enable = true;
    baseIndex = 1; # start numbering at 1 instead of 0
    escapeTime = 0; # don't add a delay to special keys
    focusEvents = true; # pass focus events from the terminal to apps
    keyMode = "vi"; # use vi-style keybindings in copy mode
    mouse = true; # use the mouse wheel to scroll through terminal output
    sensibleOnTop = true;
    shortcut = "Space";
    terminal = "screen-256color"; # recommended by nvim

    extraConfig = ''
      # Configure the status bar.
      set -g status-position bottom
      set -g status-bg black
      set -g status-fg brightgreen
      set -g status-right '#[fg=brightgreen] %I:%M %p   %a %b %d, %Y '
      setw -g window-status-format "#[bg=black]#[fg=brightgreen] #I#[fg=brightgreen]#[bg=black] #W "
      setw -g window-status-current-format "#[bg=green]#[fg=brightwhite] #I#[fg=brightwhite]#[bg=green] #W "

      # Don't rename windows automatically.
      set -g allow-rename off
      set-window-option -g automatic-rename off

      # Switch windows with Alt+#.
      bind-key -n M-1 select-window -t 1
      bind-key -n M-2 select-window -t 2
      bind-key -n M-3 select-window -t 3
      bind-key -n M-4 select-window -t 4
      bind-key -n M-5 select-window -t 5
      bind-key -n M-6 select-window -t 6
      bind-key -n M-7 select-window -t 7
      bind-key -n M-8 select-window -t 8
      bind-key -n M-9 select-window -t 9

      # Tab and session management.
      bind-key -n M-w choose-window
      bind-key -n C-M-t new-window
      bind-key C-c new-window
      bind-key C-d detach
      bind-key C-Space last-window

      # Start a new session.
      bind S command-prompt -p "New Session:" "new-session -A -s '%%'"

      # Tell tmux that the terminal supports RGB color.
      set -ag terminal-features 'xterm-256color:RGB'
    '';
  };
}
