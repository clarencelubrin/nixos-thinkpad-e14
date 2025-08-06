{pkgs, lib, config, ...}:
{
  options = {
    bash-cli.enable = lib.mkEnableOption "enables config";
  };
  config = lib.mkIf config.bash-cli.enable {
    # Aliases
    # ~/scripts/
    # hm-config.sh     nixos-config.sh  
    programs.bash = {
      enable = true;
      shellAliases = {
        nixos = "~/scripts/nixos.sh";
        switch = "~/scripts/nix-switch.sh";
        update = "sudo nixos-rebuild switch --flake /etc/nixos";
        cd-nix = "cd /etc/nixos/";
      };
    };
  };
}
