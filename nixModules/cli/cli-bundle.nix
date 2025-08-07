{pkgs, lib, config, ...}:
{
  imports = [
    ./bash.nix
    ./zsh.nix
    ./docker.nix
  ];
}
