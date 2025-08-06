{ pkgs, lib, config, ... }:
{
  options = {
    git-app.enable = lib.mkEnableOption "enables git";
  };
  config = lib.mkIf config.git-app.enable {
    programs.git = {
      enable = true;
      userName = "clarencelubrin";
      userEmail = "culubrin@up.edu.ph";
      lfs.enable = true;
    };
  };
}
