{ config, lib, pkgs, ... }:
{
  config.programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks."*" = {
      addKeysToAgent = "yes";
    };
  };

  config.services.ssh-agent = {
    enable = true;
  };
}
