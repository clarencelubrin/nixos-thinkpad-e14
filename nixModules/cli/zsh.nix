{pkgs, lib, config, ...}:
{
  options = {
    zsh-cli.enable = lib.mkEnableOption "enables config";
  };
  config = lib.mkIf config.zsh-cli.enable {
    environment.shells = with pkgs; [ zsh ];
    users.defaultUserShell = pkgs.zsh;
    environment.systemPackages = with pkgs; [
      zsh
    ];
    programs.zsh = {
      enable = true;
    };
  };
}
