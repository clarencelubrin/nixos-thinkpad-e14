{pkgs, lib, config, ...}:
{
  options = {
    home-packages-conf.enable = lib.mkEnableOption "enables config";
  };
  config = lib.mkIf config.home-packages-conf.enable {
    home.packages = with pkgs; [
      # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

      # (pkgs.writeShellScriptBin "my-hello" ''
      #   echo "Hello, ${config.home.username}!"
      # '')

      # Themes
      whitesur-icon-theme
      bibata-cursors

      # Applications
      discord
      vscode
      eclipses.eclipse-java
      firefox
      obsidian
      cryptomator
      anydesk
      ungoogled-chromium
      onlyoffice-desktopeditors
      gimp3-with-plugins
      
      # Media
      qbittorrent
      vlc

      # Creative Applications
      musescore
      muse-sounds-manager
      davinci-resolve
    ];
  };
}
