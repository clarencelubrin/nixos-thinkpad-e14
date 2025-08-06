{ pkgs, lib, config, ... }:
{
  options = {
    test.enable = lib.mkEnableOption "enables test";
  };
  config = lib.mkIf config.df-app.enable {
    programs.test = {
      enable = true;
    };
  };
}
