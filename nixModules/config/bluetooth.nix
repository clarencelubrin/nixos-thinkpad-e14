{pkgs, lib, config, ...}:
{
  options = {
    bluetooth-conf.enable = lib.mkEnableOption "enables config";
  };
  config = lib.mkIf config.bluetooth-conf.enable {
    # Disable auto-start bluetooth.
    hardware.bluetooth.enable = true;
     # Optional GUI
    services.blueman.enable = true;

    # Declaratively set /etc/bluetooth/main.conf
    environment.etc."bluetooth/main.conf".text = lib.mkForce ''
      [Policy]
      AutoEnable=false
    '';
  };
}
