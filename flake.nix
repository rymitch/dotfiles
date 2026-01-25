{
  description = "My Home Manager configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-lima = {
      url = "github:nixos-lima/nixos-lima";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixos-lima, nixos-wsl, ... }: {

    nixosConfigurations.nixos-utm = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [
        ./hosts/nixos-utm/configuration.nix
        home-manager.nixosModules.home-manager {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.rmitchell = import ./home.nix;
            backupFileExtension = "backup";
          };
        }
      ];
    };

    #nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
    #  system = "x86_64-linux";
    #  modules = [
    #    nixos-wsl.nixosModules.default
    #    {
    #      system.stateVersion = "25.05";
    #      wsl.enable = true;
    #    }
    #  ];
    #};

    #nixosConfigurations.nixsample-aarch64 = nixpkgs.lib.nixosSystem {
    #  system = "aarch64-linux";
    #  specialArgs = { inherit nixos-lima; };
    #  modules = [
    #    home-manager.nixosModules.home-manager {
    #      home-manager = {
    #        sharedModules = [ ];
    #        useGlobalPkgs = true;
    #        useUserPackages = true;
    #      };
    #    }
    #    ./hosts/lima
    #  ];
    #};

    #homeConfigurations.nixos = home-manager.lib.homeManagerConfiguration {
    #  inherit pkgs;
    #  modules = [ ./home.nix ];
    #};
    #homeConfigurations.rmitchell = home-manager.lib.homeManagerConfiguration {
    #  inherit pkgs;
    #  modules = [ ./home.nix ];
    #};
    #homeConfigurations.rjmitchell = home-manager.lib.homeManagerConfiguration {
    #  inherit pkgs;
    #  modules = [ ./home.nix ];
    #};
  };
}
