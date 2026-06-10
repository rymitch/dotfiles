{ config, lib, pkgs, ... }:
{
  config.programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings."*" = {
      addKeysToAgent = "yes";
    };
  };

  config.services.ssh-agent = {
    enable = true;
  };
}
