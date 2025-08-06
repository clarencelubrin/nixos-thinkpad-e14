{pkgs, lib, config, ...}:
{
  options = {
    module1.enable = lib.mkEnableOption "enables config";
  };
  config = lib.mkIf config.module1.enable {

  };
}
