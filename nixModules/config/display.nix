{pkgs, lib, config, ...}:
{
  options = {
    display-conf.enable = lib.mkEnableOption "enables config";
  };
  config = lib.mkIf config.display-conf.enable {
    # Xserver config
    services.xserver = {
      enable = true;
      # Enable gdm
      displayManager.gdm = {
        enable = true;
        wayland = true;
      };
      # Gnome desktop environment
      desktopManager.gnome = {
        enable = true;
        extraGSettingsOverridePackages = [ pkgs.mutter ];
        extraGSettingsOverrides = ''
          [org.gnome.mutter]
          experimental-features=[ 'scale-monitor-framebuffer' ]
        '';
      };
    };

    # Enable Gnome or Gtk themes via home-manager  
    programs.dconf.enable = true;

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      QT_QPA_PLATFORM = "wayland";
      MOZ_ENABLE_WAYLAND = "1";
      GTK_USE_PORTAL = "1";
      XDG_CURRENT_DESKTOP = "GNOME";
    };


    # Configure keymap in X11
    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };

  };
}
