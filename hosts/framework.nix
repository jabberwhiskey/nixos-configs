{
  pkgs,
  config,
  inputs,
  lib,
  ...
}: {
  imports = [
    ../system/basic.nix
    ../system/lanzaboote.nix
#    ../system/intel-laptop.nix
    ../system/greetd.nix
    ../system/qt.nix
    ../system/steam.nix
    ../system/tailscale.nix
    #../system/plasma.nix
    ../system/fonts.nix
    ../system/hyprpam.nix
#    ../system/suspend.nix
    ../system/systemdboot.nix
    ../system/virtmanager.nix
    ../system/containers.nix
    ../user/user.nix
    ../hardware/framework.nix
    ../system/sdr.nix
    ../system/kernel-latest.nix
  ];
  system.stateVersion = "23.05";
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs;};
    users.jcw = {
      imports = [
        ../home/home.nix
        ../home/hm-dconf.nix
      	../home/nvim.nix
        ../home/anyrun.nix
        ../home/bash.nix
        ../home/hypr-swap-escape.nix
        ../home/zsh.nix
        ../home/waybar.nix
        ../home/hyprland.nix
        ../home/inhibit-hyprland.nix
      ];
      home.stateVersion = "23.05";
      wayland.windowManager.hyprland = {
        package = null;
        portalPackage = null;
      };
      programs.foot.settings.main.font = lib.mkForce "monospace:size=14";
    };
  };
  boot.loader.efi.efiSysMountPoint = lib.mkForce "/boot";
  boot.kernelParams = ["module_blacklist=hid_sensor_hub"];
  nixpkgs.hostPlatform = "x86_64-linux";


#  services.fprintd.package = pkgs.fprintd.overrideAttrs {
#    mesonCheckFlags = [
#      "--no-suite"
#      "fprintd:TestPamFprintd"
#    ];
#  }; # for a failed fprintd build
#  services.fprintd.enable = lib.mkForce false; #disbale fprintd becasue it fails all the time

  networking.hostName = "framework";

  environment.systemPackages = with pkgs; [
    chezmoi
    usbutils
    fw-ectool
    sbctl
    pciutils
    kdePackages.kwallet
    multivnc
    inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
  ];
  security.pam.services.jcw.kwallet = {
    forceRun = true;
    enable = true;
    package = pkgs.kdePackages.kwallet;
  };
  #  services.xserver.displayManager.sessionPackages = with pkgs; [
  #    sway
  #  ];
    programs.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };
  hardware.brillo.enable = true;
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  powerManagement = {
    enable = true;
  };
}
