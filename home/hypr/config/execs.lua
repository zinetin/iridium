-- Exec-once
hl.on("hyprland.start", function()
  hl.exec_cmd("/run/current-system/sw/libexec/polkit-gnome-authentication-agent-1")
  hl.exec_cmd("awww-daemon")
  hl.exec_cmd('sleep 1 && wallpaper-random"}')
end)
