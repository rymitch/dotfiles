{ config, lib, pkgs, ... }:
{
  config.programs.tmux = {
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
