{pkgs, lib, config, ...}:
{
  imports = [
    ./nvchad.nix
    ./zsh.nix
    ./git.nix
  ];
}
