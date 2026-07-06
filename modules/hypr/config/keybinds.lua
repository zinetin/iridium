-- Keybinds
hl.bind("SUPER + w",                   hl.dsp.exec_cmd("zen-beta"))
hl.bind("SUPER + e",                   hl.dsp.exec_cmd("thunar"))
hl.bind("SUPER + t",                   hl.dsp.exec_cmd("kitty"))
hl.bind("SUPER + m",                   hl.dsp.exec_cmd("feishin"))
hl.bind("SUPER + y",                   hl.dsp.exec_cmd("steam"))


-- Vim bind anywhere 
hl.bind("ALT + h",                     hl.dsp.send_shortcut({ mods = "", key = "left", window = "activewindow" }))
hl.bind("ALT + j",                     hl.dsp.send_shortcut({ mods = "", key = "down", window = "activewindow" }))
hl.bind("ALT + k",                     hl.dsp.send_shortcut({ mods = "", key = "up", window = "activewindow" }))
hl.bind("ALT + l",                     hl.dsp.send_shortcut({ mods = "", key = "right", window = "activewindow" }))
hl.bind("ALT + x",                     hl.dsp.send_shortcut({ mods = "", key = "backspace", window = "activewindow" }))

-- Media control
hl.bind("SUPER + CONTROL + 5",         hl.dsp.exec_cmd("playerctl previous"))
hl.bind("SUPER + CONTROL + 6",         hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("SUPER + CONTROL + 7",         hl.dsp.exec_cmd("playerctl next"))

hl.bind("SUPER + CONTROL + 8",         hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -2%"))
hl.bind("SUPER + CONTROL + 9",         hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ toggle"))
hl.bind("SUPER + CONTROL + 0",         hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +2%"))

-- Screenshots
local screenshot_dir = os.getenv("HOME") .. "Pictures/Screenshots"

hl.bind("SUPER + SHIFT + S",           hl.dsp.exec_cmd("grimblast --notify copysave area " .. screenshot_dir .. "/$(date +%Y%m%d-%H%M%S).png"))

hl.bind("CTRL + SUPER + SHIFT + S",    hl.dsp.exec_cmd([[bash -c 'FILE="$HOME/Pictures/Screenshots/$(date +%Y%m%d-%H%M%S).png"; grimblast save area - | satty --filename - --output-filename "$FILE" && wl-copy < "$FILE" && notify-send "Screenshot saved" "$FILE"']]))

hl.bind("Print",                       hl.dsp.exec_cmd("grimblast --notify copysave output " .. screenshot_dir .. "/$(date +%Y%m%d-%H%M%S).png"))

hl.bind("CTRL + Print",                hl.dsp.exec_cmd([[ bash -c 'FILE="$HOME/Pictures/Screenshots/$(date +%Y%m%d-%H%M%S).png"; grimblast save output - | satty --filename - --output-filename "$FILE" && wl-copy < "$FILE" && notify-send "Screenshot saved" "$FILE"' ]]))

-- Workspace and Window Management

hl.bind("SUPER + F",                   hl.dsp.window.fullscreen({mode = "fullscreen", action = "toggle"}))
hl.bind("SUPER + SHIFT + F",           hl.dsp.window.fullscreen({mode = "maximized", action = "toggle"}))

hl.bind("SUPER + Q",                   hl.dsp.window.close())

hl.bind("SUPER + CONTROL +  Right",    hl.dsp.focus({ workspace = "+1" }))
hl.bind("SUPER + CONTROL +  Left",     hl.dsp.focus({ workspace = "-1" }))

hl.bind("SUPER + Space",               hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + mouse:272",           hl.dsp.window.drag(), {mouse = true })
hl.bind("SUPER + mouse:273",           hl.dsp.window.resize(), {mouse = true })

for i = 1, 4 do
  local arrowkey =  { "Left",   "Right", "Up",     "Down"}
  local vimrowkey = { "h",      "l",     "k",      "j"}
  local focusdir =  { "l",      "r",     "u",      "d"}
  local resizedir = { {-10, 0}, {10, 0}, {0, -10}, {0, 10} }
  hl.bind("SUPER + " .. arrowkey[i], hl.dsp.focus({direction = focusdir[i]}))
  hl.bind("SUPER + " .. vimrowkey[i], hl.dsp.focus({direction = focusdir[i]}))
  hl.bind("SUPER + SHIFT + " .. arrowkey[i], hl.dsp.window.move({direction = focusdir[i]}))
  hl.bind("SUPER + SHIFT + " .. vimrowkey[i], hl.dsp.window.move({direction = focusdir[i]}))
  hl.bind("SUPER + CONTROL + " .. arrowkey[i], hl.dsp.window.resize({ x = resizedir[i][0], y = resizedir[i][1], relative = true }), {repeating = true})
  hl.bind("SUPER + CONTROL + " .. vimrowkey[i], hl.dsp.window.resize({ x = resizedir[i][0], y = resizedir[i][1], relative = true }), {repeating = true})
end

for i = 0, 9 do
  hl.bind("SUPER + " .. i,  function()
    local current = hl.get_active_workspace()
    local current_id = current.id
    local decade = math.floor((current_id - 1) / 10) * 10
    local target = decade + (i == 0  and 10 or i)

    hl.dispatch(hl.dsp.focus({ workspace = target }))
  end)
end

for i = 0, 9 do
  hl.bind("SUPER + SHIFT + " .. i,  function()
    local current = hl.get_active_workspace()
    local current_id = current.id
    local decade = math.floor((current_id - 1) / 10) * 10
    local target = decade + (i == 0  and 10 or i)

    hl.dispatch(hl.dsp.window.move({ workspace = target, follow = true }))
  end)
end

for i = 0, 9 do
  hl.bind("SUPER + ALT + " .. i,  function()
    local current = hl.get_active_workspace()
    local current_id = current.id
    local decade = math.floor((current_id - 1) / 10) * 10
    local target = decade + (i == 0  and 10 or i)

    hl.dispatch(hl.dsp.window.move({ workspace = target, follow = false }))
  end)
end
