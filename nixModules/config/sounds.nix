{ pkgs, lib, config, ... }:

{
  options = {
    sounds-conf.enable = lib.mkEnableOption "enables config";
  };

  config = lib.mkIf config.sounds-conf.enable {
    # Enable rtkit (needed for PipeWire real-time scheduling)
    security.rtkit.enable = true;

    # Enable PipeWire (modern sound server)
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # Uncomment to enable JACK support
      # jack.enable = true;
    };

    # Disable PulseAudio (conflicts with PipeWire)
    services.pulseaudio.enable = false;
  };
}

