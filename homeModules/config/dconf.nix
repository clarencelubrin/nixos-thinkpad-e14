{pkgs, lib, config, ...}:
{
  options = {
    dconf-conf.enable = lib.mkEnableOption "enables config";
  };
  config = lib.mkIf config.dconf-conf.enable {
    home.packages = {
      pkgs.
    }
    dconf = {
      enable = true;
      settings = {
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
          icon-theme = "WhiteSur";
          cursor-theme = "Bibata-Modern-Classic";
        };
        "org/gnome/desktop/wm/preferences" = {
            button-layout = "appmenu:minimize,maximize,close";
        };
        "org/gnome/shell" = {
          # disable-user-extensions = true; # Optionally disable user extensions entirely
          enabled-extensions = [
            # Put UUIDs of extensions that you want to enable here.
            # If the extension you want to enable is packaged in nixpkgs,
            # you can easily get its UUID by accessing its extensionUuid
            # field (look at the following example).
            pkgs.gnomeExtensions.gsconnect.extensionUuid
            # Alternatively, you can manually pass UUID as a string.
            # "blur-my-shell@aunetx"
            # "dash-to-dock@micxgx.gmail.com"
            # ...
          ];
        };

        # Configure individual extensions
        # "org/gnome/shell/extensions/blur-my-shell" = {
        #   brightness = 0.75;
        #   noise-amount = 0;
        # };
      };
    };
  };
}
