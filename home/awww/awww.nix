{config, pkgs, lib, ...}:
with lib;
let
  cfg = config.programs.iridium;
in 
{
  options.programs.iridium = {
    wallpaperDir = mkOption {
      type = types.path;
      default = ./wallpapers;
      defaultText = literalExpression "./wallpapers (bundled with the flake)";
      description = ''
        Directory containing wallpaper images.
        Override this to point at your own wallpaper directory instead
        of the ones bundled with this flake, e.g.:
          programs.iridium.wallpaperDir = /home/you/Pictures/wallpapers;
      '';
    };

    wallpaper = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = "Specific filename (relative to wallpaperDir) to set on login. Null = pick randomly.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.awww
      pkgs.findutils
      (pkgs.writeShellScriptBin "wallpaper-random" ''
        exec ${pkgs.awww}/bin/awww img "$(find ~/.wallpapers -type f | shuf -n1)" --transition-type wipe
      '')
    ];

    home.file.".wallpapers".source = cfg.wallpaperDir;

  };
}
