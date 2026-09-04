{config, pkgs, lib, ...}:

let
  cfg = config.programs.iridium;
in 
{
  imports = [
    ./qs/quickshell.nix
    ./hypr/hyprland.nix
    ./awww/awww.nix
  ];

  config = lib.mkIf cfg.enable {
  };
}
