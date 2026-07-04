{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.iridium;
in
{
  options.programs.iridium = {
    enable = mkEnableOption "Iridium DE with Hyprland system-wide support";
  };

  config = mkIf cfg.enable {
    # Enable Hyprland system-wide
    programs.hyprland.enable = true;
    
    # Portal setup (optional but recommended)
    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
      configPackages = [ pkgs.hyprland ];
    };
  };
}
