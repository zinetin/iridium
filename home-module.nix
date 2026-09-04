{config, lib, pkgs, ...}:

with lib;

let
  cfg = config.programs.iridium;
in 
{
  imports = [
    ./home/home.nix
  ];
  options.programs.iridium = {
    enable = mkEnableOption "Hyprland + Quickshell config";
  };
}
