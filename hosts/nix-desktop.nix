{
  pkgs,
  config,
  inputs,
  lib,
  ...
}:
{
  imports = [
    ../system/basic.nix
    ../system/bt-off.nix
#    ../system/plasma.nix
    ../system/systemdboot.nix
    ../system/tailscale.nix
    ../system/containers.nix
    ../system/virtmanager.nix
    ../hardware/desktop.nix
<<<<<<< HEAD
<<<<<<< HEAD
    ../system/hyprland.nix
=======
>>>>>>> e1d11bc (cleaned up config)
=======
    ../system/hyprland.nix
>>>>>>> 6f9a7b7 (updated lockfile fixed rofi)
    #../system/qt.nix
    ../system/bluetooth.nix
    ../system/fonts.nix
    #../system/kernel-latest.nix
    ../system/kernel-zen.nix
<<<<<<< HEAD
<<<<<<< HEAD
    ../system/greetd.nix
=======
    #../system/greetd.nix
>>>>>>> e1d11bc (cleaned up config)
=======
    ../system/greetd.nix
>>>>>>> 6f9a7b7 (updated lockfile fixed rofi)
    ../system/steam.nix
  ];
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users.jcw = {
      imports = [
        ../home/home.nix
        ../home/bash.nix
        ../home/zsh.nix
<<<<<<< HEAD
<<<<<<< HEAD
        ../home/inhibit-hyprland.nix
        ../home/waybar2.nix
        ../home/hm-dconf.nix
      ];
      home.stateVersion = "24.11";
      wayland.windowManager.hyprland = {
      	settings.debug = { full_cm_proto=true; };
	settings.monitor = [
	  "DP-1, 2560x1440@239.95799, 0x0, 1, bitdepth, 10, cm, hdr"
          "DP-2, 3840x2160@59.99700, -170x-1080, 2"
	  "HDMI-A-1, disable"
	  ];
	  settings.bind =
	  [ "$mod Alt, F, exec, hyprctl keyword monitor HDMI-A-1, enable " 
	   "$mod Alt, G, exec, hyprctl keyword monitor HDMI-A-1, disable " ];
      };
    };
  };
  #specialArgs = { inherit inputs; };
=======
        #../home/inhibit-hyprland.nix
        #../home/waybar2.nix
        #../home/hyprland.nix
=======
        ../home/inhibit-hyprland.nix
        ../home/waybar2.nix
>>>>>>> 6f9a7b7 (updated lockfile fixed rofi)
        ../home/hm-dconf.nix
      ];
      home.stateVersion = "24.11";
      wayland.windowManager.hyprland = {
      	settings.debug = { full_cm_proto=true; };
	settings.monitor = [
	  "DP-1, 2560x1440@239.95799, 0x0, 1, bitdepth, 10, cm, hdr"
          "DP-2, 3840x2160@59.99700, -170x-1080, 2"
	  "HDMI-A-1, disable"
	  ];
	  settings.bind =
	  [ "$mod Alt, F, exec, hyprctl keyword monitor HDMI-A-1, enable " 
	   "$mod Alt, G, exec, hyprctl keyword monitor HDMI-A-1, disable " ];
      };
    };
  };
<<<<<<< HEAD
>>>>>>> e1d11bc (cleaned up config)
=======
  #specialArgs = { inherit inputs; };
>>>>>>> 6f9a7b7 (updated lockfile fixed rofi)
  system.stateVersion = "24.11";
  boot.loader.efi.efiSysMountPoint = lib.mkForce "/boot";

  networking.hostName = "nix-desktop";

  services.ratbagd.enable = true;

  users.users.jcw = {
    extraGroups = [
      "input"
<<<<<<< HEAD
<<<<<<< HEAD
      "dialout"
=======
>>>>>>> e1d11bc (cleaned up config)
=======
      "dialout"
>>>>>>> 6f9a7b7 (updated lockfile fixed rofi)
    ];
  };
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  programs.kdeconnect.enable = true;

  environment.systemPackages = with pkgs; [
    usbutils
<<<<<<< HEAD
<<<<<<< HEAD
=======
    #lxqt.lxqt-policykit
>>>>>>> e1d11bc (cleaned up config)
=======
>>>>>>> 6f9a7b7 (updated lockfile fixed rofi)
    bazecor
    pciutils
    g810-led
    piper
    wine
    daggerfall-unity
  ];
  hardware = {
    steam-hardware.enable = true;
  };

  boot.extraModulePackages = with config; [ pkgs.linuxPackages_zen.system76 ];
  #boot.extraModulePackages = with config; [pkgs.linuxKernel.packages.linux_6_15.system76-io];
  hardware.xone.enable = true;
  #powerManagement = {
  #  enable = true;
  #  cpuFreqGovernor = "performance";
  #};
<<<<<<< HEAD
<<<<<<< HEAD
=======
  #programs.hyprland = {
  #  enable = true;
  #  package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
  #  portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  #};
>>>>>>> e1d11bc (cleaned up config)
=======
>>>>>>> 6f9a7b7 (updated lockfile fixed rofi)
  nixpkgs.hostPlatform = "x86_64-linux";
}
