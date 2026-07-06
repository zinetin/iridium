hl.animation({
  leaf = "global",
  enabled = false,
})

hl.monitor({
  output = "eDP-1",
  mode = "1920x1080@60",
  position = "0x0",
  scale = 1,
})

hl.config({
  general = {
    layout = "scrolling"
  },
  scrolling = {
    direction = "right",
  }
})

hl.config({
  misc = {
    force_default_wallpaper = 0,
    disable_hyprland_logo = false,
  }
})
