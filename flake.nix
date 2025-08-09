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
    
    # Note: Using 'master' (or a branch that actually contains the module)
    i915-sriov-src = {
      url = "github:strongtz/i915-sriov-dkms/master";
      flake = false;
    };
  };
  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    specialArgs = { inherit system inputs; };
    extraSpecialArgs = { inherit system inputs; };

  in {
    homeModules = {
      default = import ./homeModules/default.nix;
    };
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        system = system;
        specialArgs = specialArgs;
        modules = [
          { nix.settings.experimental-features = [ "nix-command" "flakes" ]; }
          { nixpkgs.overlays = [
            (final: prev: {
              i915-sriov = prev.stdenv.mkDerivation {
                pname = "i915-sriov";
                version = "git";
                src = inputs.i915-sriov-src;
                nativeBuildInputs = [ config.boot.kernelPackages.kernel.dev ];
                buildInputs = [ config.boot.kernelPackages.kernel ];
                installPhase = ''
                  mkdir -p $out/lib/modules/${prev.kernel.modDirVersion}/extra
                  cp drivers/gpu/drm/i915/* $out/lib/modules/${prev.kernel.modDirVersion}/extra
                '';
              };
            })
          ];}
          ./configuration.nix
          ./nixModules
          home-manager.nixosModules.home-manager {
            home-manager = {
              inherit extraSpecialArgs;
              useGlobalPkgs = true;
              useUserPackages = true;
              # users.lubrin = import ./home.nix;
              users.lubrin = {
                imports = [
                  ./home.nix
                  inputs.self.outputs.homeModules.default
                ];
              };
            };
          }
        ];
      };
    };
  };
 }
