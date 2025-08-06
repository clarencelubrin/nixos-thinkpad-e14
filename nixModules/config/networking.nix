{pkgs, lib, config, ...}:
{
  options = {
    networking-conf.enable = lib.mkEnableOption "enables config";
  };
  config = lib.mkIf config.networking-conf.enable {
    networking.hostName = "thinkpad-e14"; # Define your hostname.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Disable waiting online after boot
    systemd.services."NetworkManager-wait-online".enable = false;

    # Enable networking
    networking.networkmanager.enable = true;
    networking.networkmanager.dns = "none";
    # Enable dnsmasq
    services.dnsmasq.enable = true;

    # Set custom DNS servers that dnsmasq will forward to
    services.dnsmasq.settings = {
      server = [
        "1.1.1.1"
        "8.8.8.8"
      ];
      listen-address = "127.0.0.1";
    };

    # Prevent NetworkManager or other tools from overwriting resolv.conf
    networking.useHostResolvConf = false;

    # Create resolv.conf pointing to dnsmasq
    environment.etc."resolv.conf".text = ''
      nameserver 127.0.0.1
    '';
  };
}
