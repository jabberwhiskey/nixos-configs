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
    ../system/fprint.nix
    ../system/brotherprinter.nix
    ../system/lanzaboote.nix
    ../system/hyprland.nix
    ../system/greetd.nix
    ../system/qt.nix
    ../system/steam.nix
    ../system/tailscale.nix
    ../system/fonts.nix
    ../system/hyprpam.nix
    ../system/systemdboot.nix
    ../system/virtmanager.nix
    ../system/containers.nix
    ../hardware/framework.nix
    ../system/sdr.nix
    #../system/kernel-latest.nix
  ];
  system.stateVersion = "23.05";
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users.jcw = {
      imports = [
        ../home/home.nix
        ../home/hm-dconf.nix
        ../home/nvim.nix
        ../home/bash.nix
        ../home/hypr-swap-escape.nix
        ../home/hypridle-extra.nix
        ../home/zsh.nix
        ../home/waybar.nix
      ];
      home.stateVersion = "23.05";
      programs.foot.settings.main.font = lib.mkForce "monospace:size=14";
    };
  };
  boot.loader.efi.efiSysMountPoint = lib.mkForce "/boot";

  nixpkgs.hostPlatform = "x86_64-linux";

  networking.hostName = "framework";
  environment.systemPackages = with pkgs; [
    usbutils
    fw-ectool
    sbctl
    pciutils
  ];
  hardware.brillo.enable = true; # brightness control in hyprland
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  powerManagement = {
    enable = true;
  };
}
