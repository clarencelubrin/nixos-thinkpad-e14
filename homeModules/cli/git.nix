{pkgs, lib, config, ...}:
{
  options = {
    git-cli.enable = lib.mkEnableOption "enables config";
  };
  config = lib.mkIf config.git-cli.enable {
    programs.git = {
      enable = true;
      userName  = "Clarence Lubrin";
      userEmail = "culubrin@up.edu.ph";
      lfs.enable = true
      aliases = {
        ci = "commit";
        co = "checkout";
        s = "status";
      };
    };
  };
}
