# configuration.nix

{ config, pkgs, inputs, ... }:
let
  # Ensure inputs is passed from specialArgs
  inputs = config.specialArgs.inputs;
in
{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # For steam proton support.
  boot.supportedFilesystems = [ "fuse" ];
  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_6_12;

  # Nix settings
  #nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.lubrin = {
    isNormalUser = true;
    description = "Clarence Lubrin";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  intel-qemu-conf.enable = true;

  # Programs
  steam-app.enable = true;
  zsh-cli.enable = true;
  protonvpn-app.enable = true;
  docker-cli.enable = true;
  virtualisation.waydroid.enable = true;
  # bottles-app.enable = true;
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
