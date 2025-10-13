{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
{
  programs.anyrun = {
#    package = inputs.anyrun.packages.${pkgs.system}.anyrun;
    enable = true;
    config = {
      x = {
        fraction = 0.5;
      };
      y = {
        fraction = 0.1;
      };
      width = {
        fraction = 0.3;
      };
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
        #inputs.anyrun.packages.${pkgs.system}.applications
        #inputs.anyrun.packages.${pkgs.system}.websearch
        # An array of all the plugins you want, which either can be paths to the .so files, or their packages
        "${pkgs.anyrun}/lib/libapplications.so"
        "${pkgs.anyrun}/lib/libwebsearch.so"
      ];
    };
    extraConfigFiles."websearch.ron".text = ''
      Config(
        // for any other plugin
        // this file will be put in ~/.config/anyrun/some-plugin.ron
        // refer to docs of xdg.configFile for available options
        engines: [DuckDuckGo],
        prefix: "?",
      )
    '';
    extraConfigFiles."applications.ron".text = ''
      Config(
        desktop_actions: true,
        terminal: Some(Terminal(
        command: "foot",
        args: "-e {}")),  
        max_entries: 10,
      )

    '';
    # Inline comments are supported for language injection into
    # multi-line strings with Treesitter! (Depends on your editor)
    extraCss = # css
      ''
        * {
        }
        box.main {
          background-color: black;
          padding: 5px;
          margin: 10px;
          border-radius: 10px;
          border: 2px solid @theme_selected_bg_color;
          box-shadow: 0 0 5px black;  
        }
        window {
          background  : transparent; 
        }
        text {
          min-height: 30px;
          padding: 5px;
          border-radius: 5px;
        }
        
        .matches {
          background-color: rgba(0, 0, 0, 0);
          border-radius: 10px;
        }
        
        box.plugin:first-child {
          margin-top: 5px;
        }
        
        box.plugin.info {
          min-width: 200px;
        }
        
        list.plugin {
          background-color: rgba(0, 0, 0, 0);
        }
        
        label.match.description {
          font-size: 10px;
        }
        
        label.plugin.info {
          font-size: 14px;
        }
        
        .match {
          background: transparent;
        }
        
        .match:selected {
          border-left: 4px solid @theme_selected_bg_color;
          background: transparent;
          animation: fade 0.1s linear;
        }
        
        @keyframes fade {
          0% {
            opacity: 0;
          }
        
          100% {
            opacity: 1;
          }
          all: unset;
          font-family: JetBrainsMono Nerd Font;

        }
        box.main {
          background-color: black;
          padding: 5px;
          margin: 10px;
          border-radius: 10px;
          border: 2px solid @theme_selected_bg_color;
          box-shadow: 0 0 5px black;  
        }
        window {
          background  : transparent; 
        }
        text {
          min-height: 30px;
          padding: 5px;
          border-radius: 5px;
        }
        
        .matches {
          background-color: rgba(0, 0, 0, 0);
          border-radius: 10px;
        }
        
        box.plugin:first-child {
          margin-top: 5px;
        }
        
        box.plugin.info {
          min-width: 200px;
        }
        
        list.plugin {
          background-color: rgba(0, 0, 0, 0);
        }
        
        label.match.description {
          font-size: 10px;
        }
        
        label.plugin.info {
          font-size: 14px;
        }
        
        .match {
          background: transparent;
        }
        
        .match:selected {
          border-left: 4px solid @theme_selected_bg_color;
          background: transparent;
          animation: fade 0.1s linear;
        }
        
        @keyframes fade {
          0% {
            opacity: 0;
          }
        
          100% {
            opacity: 1;
          }
        }
      '';

  };
  wayland.windowManager.hyprland.settings.bind = [ "$mod, R, exec, anyrun" ];
}
