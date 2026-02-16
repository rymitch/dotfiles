{ config, nvf, lib, pkgs, ... }:
{
  config.home.packages = [
    pkgs.ghostscript
    pkgs.imagemagick
  ];

  config.programs.fd = {
    enable = true;
  };

  config.programs.lazygit = {
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
        };
        languages = {
          enableTreesitter = true;
          enableFormat = true;
          nix.enable = true;
          markdown.enable = true;
          python.enable = true;
        };
        keymaps = [
          {
            key = "<leader><space>";
            mode = "n";
            silent = true;
            action = "<cmd>lua Snacks.picker.files()<cr>";
            desc = "Find Files (Root Dir)";
          }
          {
            key = "<leader>,";
            mode = "n";
            silent = true;
            action = "<cmd>lua Snacks.picker.buffers()<cr>";
            desc = "Buffers";
          }
          {
            key = "<leader>/";
            mode = "n";
            silent = true;
            action = "<cmd>lua Snacks.picker.grep()<cr>";
            desc = "Grep (Root Dir)";
          }
          {
            key = "H";
            mode = "n";
            silent = true;
            action = "<cmd>:bp<cr>";
            desc = "Next buffer";
          }
          {
            key = "L";
            mode = "n";
            silent = true;
            action = "<cmd>:bn<cr>";
            desc = "Previous buffer";
          }
        ];
        lsp = {
          enable = false;
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
        utility.snacks-nvim = {
          enable = true;
          setupOpts = {
            bigfile.enabled = true;
            explorer.enabled = true;
            image.enabled = true;
            input.enabled = true;
            notifier.enabled = true;
            picker.enabled = true;
            quickfile.enabled = true;
            scope.enabled = true;
            scroll.enabled = true;
            statuscolumn.enabled = true;
            words.enabled = true;
          };
        };
      };
    };
  };

  config.programs.ripgrep = {
    enable = true;
  };
}
