{
  description = "My Home Manager configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf = {
      url = "github:notashelf/nvf";
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

  outputs = { self, nixpkgs, home-manager, nvf, nixos-lima, nixos-wsl, nix-darwin, ... }: {

    nixosConfigurations.nixos-hv = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit home-manager;
        inherit nvf;
        loginName = "rjmitchell";
        displayName = "Ryan Mitchell";
      };
      modules = [
        home-manager.nixosModules.home-manager
        ./hosts/nixos-hv/configuration.nix
      ];
    };

    nixosConfigurations.nixos-lima = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      specialArgs = {
        inherit home-manager;
        inherit nixos-lima;
        inherit nvf;
        loginName = "rmitchell";
        displayName = "Ryan Mitchell";
      };
      modules = [
        home-manager.nixosModules.home-manager
        ./hosts/nixos-lima/configuration.nix
      ];
    };

    nixosConfigurations.nixos-utm = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      specialArgs = {
        inherit home-manager;
        inherit nvf;
        loginName = "rmitchell";
        displayName = "Ryan Mitchell";
      };
      modules = [
        home-manager.nixosModules.home-manager
        ./hosts/nixos-utm/configuration.nix
      ];
    };

    nixosConfigurations.nixos-wsl = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit home-manager;
        inherit nvf;
        loginName = "rjmitchell";
        displayName = "Ryan Mitchell";
      };
      modules = [
        nixos-wsl.nixosModules.default
        ./hosts/nixos-wsl/configuration.nix
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
            users."${loginName}" = import ./home/home.nix {
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
    #  modules = [ ./home/home.nix ];
    #};
    #homeConfigurations.rmitchell = home-manager.lib.homeManagerConfiguration {
    #  inherit pkgs;
    #  modules = [ ./home/home.nix ];
    #};
    #homeConfigurations.rjmitchell = home-manager.lib.homeManagerConfiguration {
    #  inherit pkgs;
    #  modules = [ ./home/home.nix ];
    #};
  };
}
