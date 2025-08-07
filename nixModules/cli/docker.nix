{pkgs, lib, config, ...}:
{
  options = {
    docker-cli.enable = lib.mkEnableOption "enables config";
  };
  config = lib.mkIf config.docker-cli.enable {
    virtualisation.docker.enable = true;
    users.extraGroups.docker.members = [ "lubrin" ];
  };
}
