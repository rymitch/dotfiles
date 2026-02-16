{ config, nvf, lib, pkgs, ... }:
{
  config.programs.fd = {
    enable = true;
  };

  config.programs.nvf = {
    enable = true;
    settings = {
      vim = {
        viAlias = true;
        vimAlias = true;
        binds = {
          whichKey = {
            enable = true;
            setupOpts = {
              notify = true;
              preset = "helix";
              win.border = "rounded";
            };
          };
          #cheatsheet.enable = true;
        };
        tabline.nvimBufferline = {
          enable = true;
          mappings = {
            closeCurrent = "<leader>bd";
          };
          setupOpts = {
            options = {
              always_show_bufferline = false;
              diagnostics = false;
              indicator = { style = "none"; };
              middle_mouse_command = "buffer %d";
              modified_icon = "●";
              numbers = "none";
              right_mouse_command = "buffer %d";
              separator_style = "thin";
              show_buffer_close_icons = false;
              show_close_icon = false;
              show_filename_only = true;
              show_modified_icon = {
                __raw = ''
                  function(buf)
                    return buf.modified
                  end'';
              };
              show_tab_indicators = false;
              sort_by = "id";
            };
          };
        };
        ui = {
          noice.enable = true;
        };
        utility = {
          snacks-nvim.enable = true;
        };
      };
    };
  };

  config.programs.ripgrep = {
    enable = true;
  };
}
