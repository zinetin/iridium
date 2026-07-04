{config, lib, pkgs, ...}:

with lib;

let
  cfg = config.programs.iridium;
in 
{
  imports = [
    ./modules/hypr/hyprland.nix
    ./modules/qs/quickshell.nix
  ];
  options.programs.iridium = {
    enable = mkEnableOption "Hyprland + Quickshell config";

    additionalConfig = mkOption {
      type = types.nullOr types.path;
      default = null;
      description = "Optional path to an additional lua file that contains your configuration";
      example = literalExpression "./custom.lua";
    };
  };
}
