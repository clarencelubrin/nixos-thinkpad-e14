# Nix module default bundle
{ pkgs, lib, ... }: {
  imports = [
    ./config/networking.nix
    ./config/bluetooth.nix
    ./config/drivers.nix
    ./config/fingerprint.nix
    ./config/locale.nix
    ./config/display.nix
    ./config/sounds.nix
    ./config/sys-packages.nix
    ./config/fonts.nix
    ./config/env.nix    
    ./applications/applications-bundle.nix
    ./cli/cli-bundle.nix
  ];
  networking-conf.enable =    lib.mkDefault true;
  bluetooth-conf.enable =     lib.mkDefault true;
  drivers-conf.enable =       lib.mkDefault true;
  fingerprint-conf.enable =   lib.mkDefault true;
  locale-conf.enable =        lib.mkDefault true;
  display-conf.enable =       lib.mkDefault true;
  sounds-conf.enable =        lib.mkDefault true;
  sys-packages-conf.enable =  lib.mkDefault true;
  fonts-conf.enable =         lib.mkDefault true;
  env-conf.enable =           lib.mkDefault true;
} 
