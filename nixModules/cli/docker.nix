{pkgs, lib, config, ...}:
{
  options = {
    bash-cli.enable = lib.mkEnableOption "enables config";
  };
  config = lib.mkIf config.bash-cli.enable {
    virtualisation.docker.enable = true;
    users.extraGroups.docker.members = [ "lubrin" ];
  };
}
