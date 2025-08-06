{pkgs, lib, config, ...}:
{
  options = {
    fonts-conf.enable = lib.mkEnableOption "enables config";
  };
  config = lib.mkIf config.fonts-conf.enable {
    # Fonts.
    fonts.packages = with pkgs; [
      pkgs.nerd-fonts.meslo-lg
    ];
  };
}
