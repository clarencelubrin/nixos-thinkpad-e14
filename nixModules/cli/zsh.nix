{pkgs, lib, config, ...}:
{
  options = {
    zsh-cli.enable = lib.mkEnableOption "enables config";
  };
  config = lib.mkIf config.zsh-cli.enable {
    # environment.shells = with pkgs; [ zsh ];
    environment.systemPackages = with pkgs; [
      thefuck
      zsh
      zsh-autosuggestions
      zsh-syntax-highlighting
      zsh-powerlevel10k
    ];
    programs.zsh = {
      enable = true;
      shellAliases = {
        nixos = "~/scripts/nixos.sh";
        switch = "~/scripts/nix-switch.sh";
        update = "sudo nixos-rebuild switch --flake /etc/nixos";
        cd-nix = "cd /etc/nixos/";
        ff = "fastfetch";
      };
      oh-my-zsh = { # "ohMyZsh" without Home Manager
        enable = true;
        plugins = [ "git" "thefuck"  "zsh-autosuggestions" "zsh-syntax-highlighting" ];
        theme = "powerlevel10k/powerlevel10k";
      };
    };
  };
}
