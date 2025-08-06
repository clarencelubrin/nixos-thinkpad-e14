# Nix module default bundle
{ pkgs, lib, ... }: {
  imports = [
    ./config/home-packages.nix
    ./config/files.nix
    ./config/session-variables.nix
    ./config/dconf.nix
    ./config/desktop-entries.nix

    ./cli/cli-bundle.nix
  ];
  home-packages-conf.enable =      lib.mkDefault true;
  files-conf.enable =              lib.mkDefault true;
  session-variables-conf.enable =  lib.mkDefault true;
  dconf-conf.enable =              lib.mkDefault true;
  desktop-entries-conf.enable =    lib.mkDefault true;
} 
