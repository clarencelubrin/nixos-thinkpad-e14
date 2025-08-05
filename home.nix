{ inputs, config, pkgs, ... }:

{
  imports = [
    inputs.nix4nvchad.homeManagerModule
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "lubrin";
  home.homeDirectory = "/home/lubrin";
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.
  nixpkgs.config.allowUnfree = true;
  # The home.packages option allows you to install Nix packages into your
  # environment.
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
    steam
    firefox
    obsidian

    # Media
    qbittorrent
    vlc

    # Creative Applications
    musescore
    muse-sounds-manager
    davinci-resolve
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/lubrin/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
  #    EDITOR = "nvim";
  };
 
  # Enable GNOME Shell extensions
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
          "dash-to-dock@micxgx.gmail.com"
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

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
