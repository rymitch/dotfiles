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
config.font = wezterm.font { family = 'MesloLGS NF', weight = 'Regular' }
config.font_size = 10.0
config.window_padding = { bottom = 0, left = 0, right = 0, top = 0  }

-- Tab bar
config.hide_tab_bar_if_only_one_tab = true
config.switch_to_last_active_tab_when_closing_tab = true
config.tab_max_width = 32
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false

-- Mouse
config.mouse_bindings = {
  { -- Disable the default click behavior
    event = { Up = { streak = 1, button = "Left"} },
    mods = "NONE",
    action = wezterm.action.DisableDefaultAssignment,
  },
  { -- Ctrl-click will open the link under the mouse cursor
      event = { Up = { streak = 1, button = "Left" } },
      mods = "CTRL",
      action = wezterm.action.OpenLinkAtMouseCursor,
  },
  { -- Disable the Ctrl-click down event to stop programs from seeing it when a URL is clicked
      event = { Down = { streak = 1, button = "Left" } },
      mods = "CTRL",
      action = wezterm.action.Nop,
  },
}

-- Keyboard: configure tmux helpers
config.keys = {
  { -- Alternate tmux leader key for OSX
    key = 'q',
    mods = 'ALT',
    action = act.SendString "\x00",
  },
  { -- tmux workspace selector
    key = 'w',
    mods = 'ALT',
    action = act.SendString "\x00s",
  },
  { -- tmux create workspace
    key = 'w',
    mods = 'ALT|SHIFT',
    action = act.SendString "\x00S",
  },
  { -- tmux copy mode
    key = 'e',
    mods = 'ALT',
    action = act.SendString "\x00[",
  },
  { -- tmux create tab
    key = 't',
    mods = 'CTRL|SHIFT',
    action = act.SendString "\x00c",
  },
}

-- Keyboard: switch tmux tabs with ALT+#
for i = 1, 8 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = 'ALT',
    action = act.SendString ("\x00" .. tostring(i)),
  })
end

-- This is a workaround so that Wayland uses
-- the standard GNOME window decorations.
config.enable_wayland = false

return config
