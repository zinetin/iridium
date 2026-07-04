{config, pkgs, ...}:

let
  cfg = config.programs.iridium;
in 
{
  config = lib.mkIf cfg.enable {
    programs.quickshell = {
      enable = true;
    };

    home.packages = with pkgs; [
      quickshell
    ];

    xdg.configFile."quickshell" = {
      source = ./config;
      recursive = true;
    };
  };
}
