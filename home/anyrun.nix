{pkgs, lib, config, inputs, ... }:
{
  programs.anyrun = {
    package = null;
    enable = true;
    config = {
      x = { fraction = 0.5; };
      y = { fraction = 0.3; };
      width = { fraction = 0.3; };
      hideIcons = false;
      ignoreExclusiveZones = false;
      layer = "top";
      hidePluginInfo = false;
      closeOnClick = false;
      showResultsImmediately = true;
      maxEntries = null;

      plugins = [
#        "${inputs.anyrun.packages.${pkgs.system}.anyrun-with-all-plugins}/lib/kidex"
#        "${inputs.anyrun.packages.${pkgs.system}.anyrun-with-all-plugins}/lib/applications"
        inputs.anyrun.packages.${pkgs.system}.applications
        inputs.anyrun.packages.${pkgs.system}.websearch
        # An array of all the plugins you want, which either can be paths to the .so files, or their packages
      ];
    };
    extraConfigFiles."websearch.ron".text = ''
      Config(
        // for any other plugin
        // this file will be put in ~/.config/anyrun/some-plugin.ron
        // refer to docs of xdg.configFile for available options
        engines: [google]
      )
    '';
    # Inline comments are supported for language injection into
    # multi-line strings with Treesitter! (Depends on your editor)
    extraCss = /*css */ ''
      entry, GtkEntry {
        background: red;
      }
      window, GtkWindow {
        opacity : 0.1; 
      }
    '';

  };
  wayland.windowManager.hyprland.settings.bind  = [ "$mod, R, exec, ${pkgs.anyrun}/bin/anyrun" ];
}
