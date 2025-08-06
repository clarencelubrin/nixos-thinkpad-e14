{pkgs, lib, config, ...}:
{
  options = {
    bluetooth-conf.enable = lib.mkEnableOption "enables config";
  };
  config = lib.mkIf config.bluetooth-conf.enable {
    # Disable auto-start bluetooth.
    hardware.bluetooth.enable = false;
  };
}
