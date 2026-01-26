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

  outputs = { self, nixpkgs, home-manager, nixos-lima, nixos-wsl, nix-darwin, ... }: {

    nixosConfigurations.nixos-hv = let
      system = "x86_64-linux";
      loginName = "rjmitchell";
      displayName = "Ryan Mitchell";
      homeDirectory = "/home/rjmitchell";
    in nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit loginName;
        inherit displayName;
      };
      modules = [
        ./hosts/nixos-hv/configuration.nix
        home-manager.nixosModules.home-manager {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users."${loginName}" = import ./home.nix {
              pkgs = nixpkgs.legacyPackages."${system}";
              inherit loginName;
              inherit displayName;
              inherit homeDirectory;
            };
            backupFileExtension = "backup";
          };
        }
      ];
    };

    nixosConfigurations.nixos-utm = let
      system = "aarch64-linux";
      loginName = "rmitchell";
      displayName = "Ryan Mitchell";
      homeDirectory = "/home/rmitchell";
    in nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit loginName;
        inherit displayName;
      };
      modules = [
        ./hosts/nixos-utm/configuration.nix
        home-manager.nixosModules.home-manager {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users."${loginName}" = import ./home.nix {
              pkgs = nixpkgs.legacyPackages."${system}";
              inherit loginName;
              inherit displayName;
              inherit homeDirectory;
            };
            backupFileExtension = "backup";
          };
        }
      ];
    };

    nixosConfigurations.nixos-wsl = let
      system = "x86_64-linux";
      loginName = "rjmitchell";
      displayName = "Ryan Mitchell";
      homeDirectory = "/home/rjmitchell";
    in nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit loginName;
        inherit displayName;
      };
      modules = [
        nixos-wsl.nixosModules.default
        {
          system.stateVersion = "25.11";
	  wsl.defaultUser = "${loginName}";
          wsl.enable = true;
        }
        home-manager.nixosModules.home-manager {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users."${loginName}" = import ./home.nix {
              pkgs = nixpkgs.legacyPackages."${system}";
              inherit loginName;
              inherit displayName;
              inherit homeDirectory;
            };
            backupFileExtension = "backup";
          };
        }
      ];
    };

    nixosConfigurations.nixos-lima = let
      system = "aarch64-linux";
      loginName = "rmitchell";
      displayName = "Ryan Mitchell";
      homeDirectory = "/home/rmitchell";
    in nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit loginName;
        inherit displayName;
        inherit nixos-lima;
      };
      modules = [
        ./hosts/lima
        home-manager.nixosModules.home-manager {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users."${loginName}" = import ./home.nix {
              pkgs = nixpkgs.legacyPackages."${system}";
              inherit loginName;
              inherit displayName;
              inherit homeDirectory;
            };
            backupFileExtension = "backup";
          };
        }
      ];
    };

    darwinConfigurations.nix-mac = let
      system = "aarch64-linux";
      loginName = "rmitchell";
      displayName = "Ryan Mitchell";
      homeDirectory = "/Users/rmitchell";
    in nix-darwin.lib.darwinSystem {
      inherit system;
      specialArgs = {
        inherit loginName;
        inherit displayName;
      };
      modules = [
        ./hosts/nix-mac/configuration.nix
        home-manager.darwinModules.home-manager {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users."${loginName}" = import ./home.nix {
              pkgs = nixpkgs.legacyPackages."${system}";
              inherit loginName;
              inherit displayName;
              inherit homeDirectory;
            };
            backupFileExtension = "backup";
          };
        }
      ];
    };

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
