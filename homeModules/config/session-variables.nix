{pkgs, lib, config, ...}:
{
  options = {
    session-variables-conf.enable = lib.mkEnableOption "enables config";
  };
  config = lib.mkIf config.session-variables-conf.enable {
    home.sessionVariables = {
    #    EDITOR = "nvim";
    };
  };
}
