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
    workspace = "special:SCRTCHPD",
    float = true,
    fullscreen = false,
  },
  center = true,
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
    float = true,
  },
})
hl.window_rule({
  name = "imv",
  match = {
    class = "imv",
    title = "imv",
    float = true,
  },
})

