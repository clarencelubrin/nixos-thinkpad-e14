{pkgs, lib, config, ...}:
{
  options = {
    desktop-entries-conf.enable = lib.mkEnableOption "enables config";
  };
  config = lib.mkIf config.desktop-entries-conf.enable {
    xdg.desktopEntries.davinci-resolve = {
        name = "DaVinci Resolve";
        genericName = "Editor";
        comment = "Professional video editing software";
        exec = "env QT_QPA_PLATFORM=xcb davinci-resolve %U";
        icon = "resolve";
        terminal = false;
        type = "Application";
        categories = [ "AudioVideo" "Video" "Graphics" ];
        mimeType = [ "application/x-resolve-project" ]; # Optional, use actual MIME types if needed
        startupNotify = true;
    };
  };
}
