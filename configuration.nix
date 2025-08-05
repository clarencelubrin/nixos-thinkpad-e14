# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ config, pkgs, inputs, ... }:
let
  # Ensure inputs is passed from specialArgs
  inputs = config.specialArgs.inputs;
in
{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # For steam proton support.
  boot.supportedFilesystems = [ "fuse" ];
  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Nix settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  #nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

  networking.hostName = "nixos"; # Define your hostname.
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

  # Disable auto-start bluetooth.
  hardware.bluetooth.enable = false;

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

  # XSERVER
  services.xserver = {
    enable = true;
    # GDM
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
    # GNOME
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
    # GTK_USE_PORTAL = "1";
    XDG_CURRENT_DESKTOP = "GNOME";
  };


  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.lubrin = {
    isNormalUser = true;
    description = "Clarence Lubrin";
    extraGroups = [ "networkmanager" "wheel" ];
  };

#  home-manager = {
#    extraSpecialArgs = { inherit inputs; };
#    users = {
#      "lubrin" = import ./home.nix;
#    };
#  };

  nixpkgs = { 
    overlays = [
      (final: prev: {
        nvchad = inputs.nix4nvchad.packages."${pkgs.system}".nvchad;
      })
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    neovim
    wget
    git
    htop
    btop
    fastfetch
    dig
    systemd
    desktop-file-utils
    usbutils
    # Formatting and Language Server for Nix
    nixpkgs-fmt
    nixd

    gnomeExtensions.blur-my-shell
    gnomeExtensions.dash-to-dock
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
