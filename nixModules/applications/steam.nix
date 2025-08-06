{ pkgs, lib, config, ... }:
{
  options = {
    steam.enable = lib.mkEnableOption "enables steam";
  };
  config = lib.mkIf config.df-app.enable {
    programs.steam = {
      enable = true;
      extraCompatPackages = [ pkgs.proton-ge-bin ];
    };
  };
}
