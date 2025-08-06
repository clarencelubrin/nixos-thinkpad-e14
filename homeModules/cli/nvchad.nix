{pkgs, lib, config, ...}:
{
  options = {
    nvchad-cli.enable = lib.mkEnableOption "enables config";
  };
  config = lib.mkIf config.nvchad-cli.enable {
    programs.nvchad = {
      enable = true;
      extraPackages = with pkgs; [
        nodePackages.bash-language-server
        docker-compose-language-service
        dockerfile-language-server-nodejs
        emmet-language-server
        nixd
        (python3.withPackages(ps: with ps; [
          python-lsp-server
          flake8
        ]))
      ];
      hm-activation = true;
      backup = true;
    };
  };
}
