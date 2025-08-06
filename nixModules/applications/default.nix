{pkgs, lib, config, ...}:
{
  options = {
    df-app.enable = lib.mkEnableOption "enables config";
  };
  config = lib.mkIf config.df-app.enable {
    programs.df = {
      enable = true;
    }
  };
}
