{pkgs, lib, config, ...}:
{
  imports = [
    ./bash.nix
    ./zsh.nix
    ./nvchad.nix
  ];
}
