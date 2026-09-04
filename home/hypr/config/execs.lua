-- Exec-once
hl.on("hyprland.start", function()
  hl.exec_cmd("qs")
  hl.exec_cmd("/run/current-system/sw/libexec/polkit-gnome-authentication-agent-1")
  hl.exec_cmd("${pkgs.awww}/bin/awww-daemon")
  hl.exec_cmd('sleep 1 && ${pkgs.awww}/bin/awww img ${if cfg.wallpaper != null then "${cfg.wallpaperDir}/${cfg.wallpaper}" else "$(find ${cfg.wallpaperDir} -type f | shuf -n1)"}')
end)
