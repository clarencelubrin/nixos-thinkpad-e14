{pkgs, lib, config, ...}:
{
  options = {
    locale-conf.enable = lib.mkEnableOption "enables config";
  };
  config = lib.mkIf config.locale-conf.enable {
    # Set your time zone.
    time.timeZone = "Asia/Manila";

    i18n = {
      defaultLocale = "en_US.UTF-8";

      extraLocaleSettings = {
        LC_ADDRESS = "en_US.UTF-8";
        LC_IDENTIFICATION = "en_US.UTF-8";
        LC_MEASUREMENT = "en_US.UTF-8";
        LC_MONETARY = "fil_PH"; # Filipino money formatting
        LC_NAME = "en_US.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "en_US.UTF-8";
        LC_TIME = "en_US.UTF-8";
      };
  };
  };
}
