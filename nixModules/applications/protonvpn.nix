{ pkgs, lib, config, ... }:
{
  options = {
    protonvpn-app.enable = lib.mkEnableOption "enables protonvpn";
  };
  config = lib.mkIf config.protonvpn-app.enable {
    networking.firewall.checkReversePath = false;
    environment.systemPackages = with pkgs; [wireguard-tools protonvpn-gui];
  };
}
