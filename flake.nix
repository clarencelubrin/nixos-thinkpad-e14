{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix4nvchad = {
      url = "github:nix-community/nix4nvchad";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    specialArgs = { inherit system inputs; };
    extraSpecialArgs = { inherit system inputs; };
  in {
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        system = system;
        specialArgs = specialArgs;
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager {
            home-manager = {
              inherit extraSpecialArgs;
              useGlobalPkgs = true;
              useUserPackages = true;
              users.lubrin = import ./home.nix;
            };
          }
        ];
      };
    };
  };

 }
