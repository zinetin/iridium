{config, pkgs, lib, ...}:

let
  cfg = config.programs.iridium;
in 
{
  config = lib.mkIf cfg.enable {
    programs.quickshell = {
      enable = true;
      systemd.enable = true;
    };

    home.packages = with pkgs; [
      quickshell
      libqalculate
    ];

    xdg.configFile."quickshell" = {
      source = ./config;
      recursive = true;
    };

#    systemd.user.services.quickshell = {
#      Unit = {
#        Description = "Quickshell";
#        After = [ "graphical-session.target" ];
#        PartOf = [ "graphical-session.target" ];
#      };
#      Service = {
#        ExecStart = "${pkgs.quickshell}/bin/quickshell";
#        Restart = "on-failure";
#      };
#      Install = {
#        WantedBy = [ "graphical-session.target" ];
#      };
#    };
  };
}
