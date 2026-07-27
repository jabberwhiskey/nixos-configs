
local mainMod = "SUPER" -- Sets "Windows" key as main modifier

hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exit())

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd("foot"))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("anyrun"))

-- Notifications with Dunst
hl.bind(mainMod .. " + Space", hl.dsp.exec_cmd("dunstctl close-all"))
hl.bind(mainMod .. "+ ALT + Space", hl.dsp.exec_cmd("dunstctl history-pop"))
local closeWindowBind = hl.bind(mainMod .. " + C", hl.dsp.window.close())

-- closeWindowBind:set_enabled(false)'
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("pcmanfm-qt"))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("cliphist list | rofi -dmenu | cliphist decode | wl-copy"))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("rofi -show drun"))
hl.bind(mainMod .. " + U", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(mainMod .. " + I", hl.dsp.layout("togglesplit"))    -- dwindle only

-- screenshots
hl.bind("Print", hl.dsp.exec_cmd("hyprshot -m output"))
hl.bind("ALT + Print", hl.dsp.exec_cmd("hyprshot -m active"))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("hyprshot -m region"))

-- Window Groups
hl.bind(mainMod .. " + SHIFT + code:59 ", hl.dsp.window.move({ into_or_create_group = "left", window = activewindow }))    
hl.bind(mainMod .. " + SHIFT + code:60 ", hl.dsp.window.move({ into_or_create_group = "right", window = activewindow }))    
hl.bind(mainMod .. "  + code:59 ", hl.dsp.group.prev({  window = activewindow }))    
hl.bind(mainMod .. "  + code:60 ", hl.dsp.group.next({  window = activewindow }))    
hl.bind(mainMod .. " + SHIFT  + code:61 ", hl.dsp.group.toggle({  window = activewindow }))    

-- scrolling and master layout
-- master
hl.bind(mainMod .. " + TAB", hl.dsp.layout("rollnext"))
hl.bind( "ALT + TAB", hl.dsp.layout("rollprev"))
--scrolling
hl.bind(mainMod .. " + bracketright", hl.dsp.layout("move +col "))
hl.bind(mainMod .. " + bracketleft", hl.dsp.layout("move -col "))
hl.bind(mainMod .. "+ ALT + P", hl.dsp.layout("colresize +conf "))
hl.bind(mainMod .. "+ ALT + O", hl.dsp.layout("colresize -conf "))
hl.bind(mainMod .. " + ALT + bracketright", hl.dsp.layout("swapcol r"))
hl.bind(mainMod .. " + ALT + bracketleft", hl.dsp.layout("swapcol l"))

-- dwindle layout binds
hl.bind(mainMod .. "+ ALT + code:51", hl.dsp.layout("swapsplit"))
hl.bind(mainMod .. " + code:51", hl.dsp.layout("togglesplit"))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + L",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J",  hl.dsp.focus({ direction = "down" }))


-- move windows on a workspace


-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + code:20",         hl.dsp.workspace.toggle_special("SCRTCHPD"))
hl.bind(mainMod .. " + SHIFT + code:20", hl.dsp.window.move({ workspace = "special:SCRTCHPD" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind(mainMod .. " + ALT + up", hl.dsp.window.resize({ x = 0, y = 10, relative = true, window = activewindow }))
hl.bind(mainMod .. " + ALT + down", hl.dsp.window.resize({ x = 0, y = -10, relative = true, window = activewindow }))
hl.bind(mainMod .. " + ALT + right", hl.dsp.window.resize({ x = 10, y = 0,  relative = true, window = activewindow }))
hl.bind(mainMod .. " + ALT + left", hl.dsp.window.resize({ x = -10, y = 0,  relative = true,  window = activewindow }))

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brillo -q -A 5"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brillo -q -U 5"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

