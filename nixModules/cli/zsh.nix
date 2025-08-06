{pkgs, lib, config, ...}:
{
  options = {
    zsh-cli.enable = lib.mkEnableOption "enables config";
  };
  config = lib.mkIf config.zsh-cli.enable {
    programs.zsh = {
      enable = true;
      shellAliases = {
        nixos = "~/scripts/nixos.sh";
        switch = "~/scripts/nix-switch.sh";
        update = "sudo nixos-rebuild switch --flake /etc/nixos";
        cd-nix = "cd /etc/nixos/";
        ff = "fastfetch";
      };
    };
  };
}
