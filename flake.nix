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
      extraSpecialArgs = { inherit system inputs; };  # <- passing inputs to the attribute set for home-manager
      # specialArgs = { inherit system inputs; };       # <- passing inputs to the attribute set for NixOS (optional)
    in {
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        modules = [
          specialArgs = { inherit system inputs; };
	  # inherit specialArgs;           # <- this will make inputs available anywhere in the NixOS configuration
          ./configuration.nix
          home-manager.nixosModules.home-manager {
            home-manager = {
	      extraSpecialArgs = { inherit system inputs; };
              # inherit specialArgs;  # <- this will make inputs available anywhere in the HM configuration
              useGlobalPkgs = true;
              useUserPackages = true;
              users.lubrin = import ./home.nix;
            };
          }
        ];
      };
    };
 }
