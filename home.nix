{ inputs, config, pkgs, ... }:

{
  imports = [
    inputs.nix4nvchad.homeManagerModule
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "lubrin";
  home.homeDirectory = "/home/lubrin";
  
  home.stateVersion = "25.05"; # Please read the comment before changing.
  nixpkgs.config.allowUnfree = true;
  
  # Enable nvchad
  nvchad-cli.enable = true;
  zsh-cli.enable = true;  
  git-cli.enable = true;
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
