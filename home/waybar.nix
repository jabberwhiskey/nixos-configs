{
#  home = {
   programs.waybar = {
     enable = true;
     settings = {
       mainBar = {
         layer = "top";
         position = "top";
         height = 45;
         modules-left = [ "hyprland/workspaces" ];
         modules-center = [ "clock" ];
         modules-right = [ "tray" "idle_inhibitor" "battery" "network" "wireplumber" ];

         "hyprland/workspaces" = {
           format = "{name}";
           on-click = "activate";
           on-scroll-up = "hyprctl dispatch workspace e+1";
           on-scroll-down = "hyprctl dispatch workspace e-1";
         };
         "clock" = {
           interval = 1;
           format = "{:%I:%M %p}";
           format-alt = "{:%A, %B %d, %Y (%r)}";
         tooltip-format = "\n<span size='9pt'> <tt><small>{calendar}</small></tt></span>";
           calendar = {
              "mode"= "year";
                     "mode-mon-col" = 3;
                     "weeks-pos" = "right";
                     "on-scroll"= 1;
                     "on-click-right"= "mode";
                     "format"= {
                               "months"=     "<span color='#ffead3'><b>{}</b></span>";
                               "days"=       "<span color='#ecc6d9'><b>{}</b></span>";
                               "weeks"=      "<span color='#99ffdd'><b>W{}</b></span>";
                               "weekdays"=   "<span color='#ffcc66'><b>{}</b></span>";
                               "today"=      "<span color='#ff6699'><b><u>{}</u></b></span>";
                               };
                     };
         "actions"=  {
                     "on-click-right"= "mode";
                     "on-click-forward"= "tz_up";
                     "on-click-backward"= "tz_down";
                     "on-scroll-up"= "shift_up";
                     "on-scroll-down"= "shift_down";
                     };
           };
           "tray" = {
             spacing = 10;
             icon-size = 20;
             show-passive-items = "true";
           };
	   idle_inhibitor = {
              format = "icon";
	      format_icons = {
                activated = "";
		deactivated = "";
	      };
	   };
           "bluetooth" = {
           	format = " {status}";
           	format-connected = " {device_alias}";
           	format-connected-battery = " {device_alias} {device_battery_percentage}%";
 	          tooltip-format= "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
 	          tooltip-format-connected= "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
 	          tooltip-format-enumerate-connected= "{device_alias}\t{device_address}";
 	          tooltip-format-enumerate-connected-battery= "{device_alias}\t{device_address}\t{device_battery_percentage}%";

           };
           "battery" = {
              bat = "BAT1";
  	          interval = 60;
  	          states = {
  		          warning = 30;
  		          critical = 15;
  	          };
  	          format = "{capacity}% {icon}";
  	          format-icons = [ "" "" "" "" ""];
  	          max-length = 25;
           };
             "network"= {
    	          interface= "wlp170s0";
    	          format= "{ifname}";
    	          format-wifi= "{essid} ({signalStrength}%) ";
    	          format-ethernet= "{ifname} ";
    	          format-disconnected= "";
    	          #format-disconnected= "";
    	          tooltip-format= "{ifname}";
              	tooltip-format-wifi= "{essid} ({signalStrength}%) ";
    	          tooltip-format-ethernet= "{ifname} ";
    	          tooltip-format-disconnected= "Disconnected";
    	          max-length= 50;
             };
             "wireplumber"= {
                format= "{volume}% {icon}";
                format-muted= "";
                on-click= "helvum";
                format-icons= ["" "" ""];
             };
         };
      };
      style = ''
            * {

     border: none;

     border-radius: 0;

     /* `otf-font-awesome` is required to be installed for icons */

     font-family: Cozette, monospace;

     font-size: 11px;

     min-height: 0;

 }

 

 window#waybar {

     background-color: #282828;

     border-bottom: 3px solid #282828;

     color: #fff;

     transition-property: background-color;

     transition-duration: .5s;

 }

 

 window#waybar.hidden {

     opacity: 0.2;

 }

 

 /*

 window#waybar.empty {

     background-color: transparent;

 }

 window#waybar.solo {

     background-color: #FFFFFF;

 }

 */

 

 #workspaces button {

     padding: 0 5px;

     background-color: #282828;

     color: #fff;

     border-bottom: 3px solid #282828;

 }

 

 #workspaces button:hover {

     background: rgba(0, 0, 0, 0.2);

     box-shadow: inherit;

     border-bottom: 3px solid #282828;

 }

 

 #workspaces button.focused {

     background-color: #fff;

     color: #282828;

     border-bottom: 3px solid #fff;

 }

 

 #workspaces button.urgent {

     background-color: #282828;

     color: #2ecc40;

     border-bottom: 3px solid #282828;

 }

 

 #mode {

     background-color: #282828;

     border-bottom: 3px solid #282828;

 }

 

 #clock,

 #battery,

 #cpu,

 #memory,

 #temperature,

 #backlight,

 #network,

 #pulseaudio,

 #custom-media,

 #tray,

 #mode,

 #idle_inhibitor,

 #mpd {

     padding: 0 10px;

     margin: 0 4px;

     color: #ffffff;

 }

 

 #clock {

     background-color: #282828;

     color: #fff;

 

 }

 

 #battery {

     background-color: #ffffff;

     color: #282828;

 }

 

 #battery.charging {

     color: #ffffff;

     background-color: #3d9970;

 }

 

 @keyframes blink {

     to {

         background-color: #ffffff;

         color: #282828;

     }

 }

 

 #battery.critical:not(.charging) {

     background-color: #ff4136;

     color: #ffffff;

     animation-name: blink;

     animation-duration: 0.5s;

     animation-timing-function: linear;

     animation-iteration-count: infinite;

     animation-direction: alternate;

 }

 

 label:focus {

     background-color: #282828;

 }

 

 #cpu {

     background-color: #282828;

     color: #fff;

 }

 

 #memory {

     background-color: #282828;

     color: #fff;

 }

 

 #backlight {

     background-color: #282828;

     color: #fff;

 }

 

 #network {

     background-color: #282828;

     color: #fff;

 }

 

 #network.disconnected {

     background-color: #282828;

     color: #fff;

 }

 

 #pulseaudio {

     background-color: #282828;

     color: #fff;

 }

 

 #pulseaudio.muted {

     background-color: #282828;

     color: #fff;

 }

 

 #temperature {

     background-color: #282828;

     color: #fff;

 }

 

 #temperature.critical {

     background-color: #282828;

     color: #fff;

 }

 

 #tray {

     background-color: #282828;

     color: #fff;

 }

 

 #idle_inhibitor {

     background-color: #282828;

     color: #fff;

 }

 

 #idle_inhibitor.activated {

     background-color: #282828;

     color: #fff;

 }
         '';
     };
#  };
}
