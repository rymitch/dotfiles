{
  description = "My Home Manager configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
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
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixos-lima, nix-darwin, ... }: {

    nixosConfigurations.nixos-hv = let
      system = "x86_64-linux";
      user = "rmitchell";
      homeDirectory = "/home/rmitchell";
    in nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit user;
      };
      modules = [
        ./hosts/nixos-hv/configuration.nix
        home-manager.nixosModules.home-manager {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.rmitchell = import ./home.nix {
              pkgs = nixpkgs.legacyPackages."${system}";
              inherit user;
              inherit homeDirectory;
            };
            backupFileExtension = "backup";
          };
        }
      ];
    };

    nixosConfigurations.nixos-utm = let
      system = "aarch64-linux";
      user = "rmitchell";
      homeDirectory = "/home/rmitchell";
    in nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit user;
      };
      modules = [
        ./hosts/nixos-utm/configuration.nix
        home-manager.nixosModules.home-manager {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users."${user}" = import ./home.nix {
              pkgs = nixpkgs.legacyPackages."${system}";
              inherit user;
              inherit homeDirectory;
            };
            backupFileExtension = "backup";
          };
        }
      ];
    };

    nixosConfigurations.nixos-lima = let
      system = "aarch64-linux";
      user = "rmitchell";
      homeDirectory = "/home/rmitchell";
    in nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit user;
        inherit nixos-lima;
      };
      modules = [
        ./hosts/lima
        home-manager.nixosModules.home-manager {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.rmitchell = import ./home.nix {
              pkgs = nixpkgs.legacyPackages."${system}";
              inherit user;
              inherit homeDirectory;
            };
            backupFileExtension = "backup";
          };
        }
      ];
    };

    darwinConfigurations.nix-mac = let
      system = "aarch64-linux";
      user = "rmitchell";
      homeDirectory = "/Users/rmitchell";
    in nix-darwin.lib.darwinSystem {
      inherit system;
      specialArgs = {
        inherit user;
      };
      modules = [
        ./hosts/nix-mac/configuration.nix
        home-manager.darwinModules.home-manager {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.rmitchell = import ./home.nix {
              pkgs = nixpkgs.legacyPackages."${system}";
              inherit user;
              inherit homeDirectory;
            };
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
