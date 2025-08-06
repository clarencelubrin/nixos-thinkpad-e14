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
      vim
      neovim
      wget
      git
      htop
      btop
      fastfetch
      dig
      systemd
      desktop-file-utils
      usbutils
      p7zip
      unzip
      unrar
      # Formatting and Language Server for Nix
      nixpkgs-fmt
      nixd
      oh-my-zsh
      zsh-powerlevel10k

      gnomeExtensions.blur-my-shell
      gnomeExtensions.dash-to-dock
      
    ];
  };
}
