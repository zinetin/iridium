-- Exec-once
hl.on("hyprland.start", function()
  hl.exec_cmd("qs")
  hl.exec_cmd("/run/current-system/sw/libexec/polkit-gnome-authentication-agent-1")
end)
