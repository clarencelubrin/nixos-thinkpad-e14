{ pkgs, lib, config, ... }:
{
  options = {
    bottles-app.enable = lib.mkEnableOption "enables bottles";
  };
  config = lib.mkIf config.bottles-app.enable {
    environment.systemPackages = with pkgs; [
      bottles
    ];
    pkgs.bottles.override {
      removeWarningPopup = true;
    }
  };
}
