{pkgs, lib, config, ...}:
{
  options = {
    env-conf.enable = lib.mkEnableOption "enables config";
  };
  config = lib.mkIf config.env-conf.enable {
    environment.shells = with pkgs; [ zsh ];
  };
}
