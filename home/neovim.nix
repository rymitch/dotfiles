{ config, nvf, lib, pkgs, ... }:
{
  config.programs.fd = {
    enable = true;
  };

  config.programs.nvf = {
    enable = true;
    settings = {
      vim.viAlias = true;
      vim.vimAlias = true;
      vim.binds = {
        whichKey.enable = true;
      };
      vim.ui = {
        noice.enable = true;
      };
      vim.tabline = {
        nvimBufferline.enable = true;
      };
      vim.telescope.enable = true;
    };
  };

  config.programs.ripgrep = {
    enable = true;
  };
}
