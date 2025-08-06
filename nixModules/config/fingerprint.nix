{pkgs, lib, config, ...}:
{
  options = {
    fingerprint-conf.enable = lib.mkEnableOption "enables config";
  };
  config = lib.mkIf config.fingerprint-conf.enable {
    # Fingerprint.
    systemd.services.fprintd = {
      wantedBy = [ "multi-user.target" ];
      serviceConfig.Type = "simple";
    };

    services.fprintd.enable = true;
    services.fprintd.tod.enable = true;
    services.fprintd.tod.driver = pkgs.libfprint-2-tod1-goodix-550a; # Goodix 550a driver (from Lenovo)

    security.polkit.debug = true; # Debugging.

    # Enable log-in with fingerprint.
    security.pam.services.gdm.enableGnomeKeyring = true;
    security.pam.services.gdm.fprintAuth = true;

    # security.pam.services.login.fprintAuth = true;
    security.pam.services.sudo.fprintAuth = true;
  };
}
