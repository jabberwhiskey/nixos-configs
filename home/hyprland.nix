{ config, pkgs, ...}:
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";
      bind = [
        "$mod, Return, exec ${pkgs.alacritty}/bin/alacritty"
        "$mod, D, exec ${pkgs.wofi}/bin/wofi  --drun"
        "$mod, M, exec ${pkgs.mc}/bin/mc"
        "SUPER_SHIFT, F, exec ${pkgs.firefox}/bin/firefox"
        "$mod, F, fullscreen"
        "$mod, Space, togglefloating,"
        "$mod, C, killactive,"
        "$mod, P, psuedo" #dwindle
        "$mod, J, togglesplit" #dwindle

        "$mod, left, movefoucus, l"
        "$mod, right, movefoucus, r"
        "$mod, up, movefoucus, u"
        "$mod, down, movefoucus, d"

        
      ]
      ++ (
      # workspaces
      # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
      builtins.concatLists (builtins.genList (
          x: let
            ws = let
              c = (x + 1) / 10;
          in
            builtins.toString (x + 1 - (c * 10));
              in [
                "$mod, ${ws}, workspace, ${toString (x + 1)}"
                "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
                ]
              )
          10)
        );
      };
    };
}
