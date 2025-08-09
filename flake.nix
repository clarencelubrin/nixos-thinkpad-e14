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
    # Add the i915-sriov repo
    i915-sriov-src = {
      url = "github:strongtz/i915-sriov-dkms.git";
      flake = false; # It's not a flake
    };
  };
  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    specialArgs = { inherit system inputs; };
    extraSpecialArgs = { inherit system inputs; };

    # Package the module
    i915-sriov = pkgs.linuxPackages.callPackage
      ({ stdenv, lib, kernel, fetchFromGitHub }:
        stdenv.mkDerivation {
          pname = "i915-sriov";
          version = "git";
          src = i915-sriov-src;
          nativeBuildInputs = kernel.moduleBuildDependencies;
          makeFlags = [ "KERNELRELEASE=${kernel.modDirVersion}" "M=${placeholder "out"}/build" ];
          buildPhase = ''
            make -C ${kernel.dev}/lib/modules/${kernel.modDirVersion}/build M=$PWD
          '';
          installPhase = ''
            mkdir -p $out/lib/modules/${kernel.modDirVersion}/extra
            cp i915-sriov.ko $out/lib/modules/${kernel.modDirVersion}/extra/
          '';
        }) {};
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
