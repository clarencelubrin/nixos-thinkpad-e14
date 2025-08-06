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
        cnf = "echo \"cnf-nix for nixos-config, cnf-home for hm-config\"";
        cnf-home = "/home/lubrin/scripts/hm-config.sh";
        cnf-nix = "/home/lubrin/scripts/nixos-config.sh";
        update = "sudo nixos-rebuild switch --flake /etc/nixos";
        cd-nx = "cd /etc/nixos/";
      };
    };
  };
}
