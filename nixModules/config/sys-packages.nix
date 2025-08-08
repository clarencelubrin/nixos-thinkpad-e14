{pkgs, lib, config, inputs, ...}:
{
  options = {
    sys-packages-conf.enable = lib.mkEnableOption "enables config";
  };
  config = lib.mkIf config.sys-packages-conf.enable {
    nixpkgs = { 
      overlays = [
        (final: prev: {
          nvchad = inputs.nix4nvchad.packages."${pkgs.system}".nvchad;
        })
      ];
    };
    environment.systemPackages = with pkgs; [
      # CLI Editors
      vim
      neovim

      # Commands
      wget
      htop
      btop
      fastfetch
      dig
      systemd
      desktop-file-utils
      usbutils

      # Archiving
      p7zip
      unzip
      unrar
      
      # Development
      git
      gcc
      cmake
      docker-compose
      devenv

      # Wine 
      wineWowPackages.stable
      winetricks      

      # Formatting and Language Server for Nix
      nixpkgs-fmt
      nixd
    ];
  };
}
