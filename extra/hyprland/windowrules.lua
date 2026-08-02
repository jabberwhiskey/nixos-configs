hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

hl.window_rule({
  name = "bitwarden",
  match = {
    class = "Bitwarden",  
    title = "Bitwarden",
  },
  center = true,
  float = true,
  workspace = "special:SCRTCHPD",
  fullscreen = false,
  size = {'(monitor_w*0.5)', '(monitor_h*0.5)' }
})
hl.window_rule({
  name = "bitwarden2",
  match = {
    class = "bitwarden",  
    title = "Bitwarden",
  },
  center = true,
  float = true,
  workspace = "special:SCRTCHPD",
  fullscreen = false,
  size = {'(monitor_w*0.5)', '(monitor_h*0.5)' }
})
hl.window_rule({
  name = "filepicker",
  match = {
    class = "xdg-desktop-portal-gtk",
    title = "All Files",
    float = true,
  },
})
hl.window_rule({
  name = "mpv",
  match = {
    class = "mpv",
    title = "mpv",
  },
    float = true,
})
hl.window_rule({
  name = "imv",
  match = {
    class = "imv",
    title = "imv",
  },
    float = true,
})

