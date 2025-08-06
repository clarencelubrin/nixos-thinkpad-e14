{ pkgs, lib, config, ... }:
{
  options = {
    steam-app.enable = lib.mkEnableOption "enables steam";
  };
  config = lib.mkIf config.steam-app.enable {
    programs.steam = {
      enable = true;
      extraCompatPackages = [ pkgs.proton-ge-bin ];
    };
  };
}
