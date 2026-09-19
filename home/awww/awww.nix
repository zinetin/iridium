{config, pkgs, lib, wallpapersSrc, ...}:
with lib;
let
  cfg = config.programs.iridium;
in 
{
  options.programs.iridium = {
    wallpaperDir = mkOption {
      type = types.path;
      default = wallpapersSrc;
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
      (pkgs.writeShellScriptBin "wallpaper-set" ''
        set -eu
        if [ -n "''${1:-}" ]; then
        img="${cfg.wallpaperDir}/$1"
        else
        img="$(find ${cfg.wallpaperDir} -type f | shuf -n1)"
        fi
        exec ${pkgs.awww}/bin/awww img "$img" --transition-type "''${AWWW_TRANSITION_TYPE:-wipe}" --transition-step "''${AWWW_TRANSITION_STEP:-200}" --transition-duration "''${AWWW_TRANSITION_DURATION:-0.5}"
       '')
      (pkgs.writeShellScriptBin "wallpaper-tree" ''
        set -eu
        ${pkgs.tree}/bin/tree ${lib.escapeShellArg cfg.wallpaperDir}
       '')
    ];

    home.file.".wallpapers".source = cfg.wallpaperDir;

  };
}
