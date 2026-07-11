{config, pkgs, lib, ...}:

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

    xdg.configFile."quickshell.bar" = {
      source = ./config/bar;
      recursive = true;
    };
    xdg.configFile."quickshell.bar" = {
      source = ./config/launcher;
      recursive = true;
    };

  };
}
