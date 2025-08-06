{pkgs, lib, config, ...}:
{
  options = {
    drivers-conf.enable = lib.mkEnableOption "enables config";
  };
  config = lib.mkIf config.drivers-conf.enable {
    # Hardware Drivers
    services.xserver.videoDrivers = [ "modesetting" ];
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver # For Broadwell (2014) or newer processors. LIBVA_DRIVER_NAME=iHD
        intel-vaapi-driver # For older processors. LIBVA_DRIVER_NAME=i965
        intel-compute-runtime
      ];
    };
    environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; };

    # Printer Drivers
    # Enable CUPS to print documents.
    services.printing.enable = true;
  };
}
