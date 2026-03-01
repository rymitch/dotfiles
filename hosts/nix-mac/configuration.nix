{ config, lib, pkgs, home-manager, homebrew-cask, homebrew-core, nix-homebrew, nvf, ... }:
let
  loginName = "rmitchell";
  displayName = "Ryan Mitchell";
  email = "ryan@mitchell.plus";
  homeDirectory = "/Users/${loginName}";
in {
  environment = {
    variables = {
      EDITOR = "nvim";
      SYSTEMD_EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users."${loginName}" = import ../../home/home.nix {
      inherit pkgs nvf loginName displayName email homeDirectory;
    };
    backupFileExtension = "backup";
  };

  homebrew = {
    enable = true;
    casks = [
      "qcad"
      "sanesidebuttons"
      "utm"
    ];
    taps = builtins.attrNames config.nix-homebrew.taps; # Align homebrew taps config with nix-homebrew
  };

  ids.gids.nixbld = 350;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "1password-cli"
    "1password"
  ];

  nixpkgs.hostPlatform = "aarch64-darwin";

  nix-homebrew = {
    enable = true;
    mutableTaps = true;
    taps = {
      "homebrew/homebrew-core" = homebrew-core;
      "homebrew/homebrew-cask" = homebrew-cask;
    };
    user = "${loginName}";
  };

  programs._1password-gui.enable = true;
  programs._1password.enable = true;
  programs.zsh.enable = true;

  services.openssh.enable = true;

  system.defaults.controlcenter.BatteryShowPercentage = true;
  system.defaults.dock.autohide = true;
  system.defaults.NSGlobalDomain.InitialKeyRepeat = 25;
  system.defaults.NSGlobalDomain."com.apple.keyboard.fnState" = true;
  system.defaults.NSGlobalDomain.KeyRepeat = 2;
  system.defaults.WindowManager.EnableStandardClickToShowDesktop = false;
  system.primaryUser = "${loginName}";
  system.stateVersion = 4;

  users.users.${loginName} = {
    name = "${loginName}";
    description = "${displayName}";
    home = "${homeDirectory}";
  };
}
