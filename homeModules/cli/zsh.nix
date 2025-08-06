{pkgs, lib, config, ...}:
{
  options = {
    zsh-cli.enable = lib.mkEnableOption "enables config";
  };
  config = lib.mkIf config.zsh-cli.enable {
    # environment.shells = with pkgs; [ zsh ];
    programs.zsh = {
      enable = true;
      history.size = 10000;
      shellAliases = {
        nixos = "~/scripts/nixos.sh";
        switch = "~/scripts/nix-switch.sh";
        update = "sudo nixos-rebuild switch --flake /etc/nixos";
        cd-nix = "cd /etc/nixos/";
        ff = "fastfetch";
      };
      oh-my-zsh = { # "ohMyZsh" without Home Manager
        enable = true;
        plugins = [ "git" ];
        theme = "powerlevel10k/powerlevel10k";
      };
      plugins = [
      {
        name = "zsh-autosuggestions";
        src = pkgs.zsh-autosuggestions;
      }
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.zsh-syntax-highlighting;
      }
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];
      initExtra = ''
        [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
      '';
    };
  };
}
