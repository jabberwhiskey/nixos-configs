{
  pkgs,
  config,
  lib,
  inputs,
  hyprland,
  ...
}: {
  imports = [
    ../system/basic.nix
    ../system/basic-stable.nix
#    ../system/u2f.nix
    ../system/tailscale.nix
    ../system/hyprpam.nix
#    ../system/suspend.nix
    ../system/qt.nix
    ../system/waydroid.nix
#    ../system/steam.nix
    ../system/intel-laptop.nix
    ../system/greetd.nix
#    ../system/kernel-latest.nix
    ../system/kernel-zen.nix
#    ../system/plasma.nix
    ../system/fonts.nix
    ../system/systemdboot.nix
    ../system/containers.nix
    ../user/user.nix
    ../hardware/hplaptop.nix
  ];
  home-manager = { 
    users.jcw = {
      wayland.windowManager.hyprland = {
        package = null;
        portalPackage = null;
      };
      programs.zsh.shellAliases = { 
        "update" = "sudo nixos-rebuild boot --flake ~/dev/nixos-configs#nixos-laptop --verbose";
        "test" = "sudo nixos-rebuild test --flake ~/dev/nixos-configs#nixos-laptop --verbose";
      };
      imports = [
        ../home/waybar.nix
        ../home/anyrun.nix
        ../home/bash.nix
        ../home/nvim.nix
        ../home/zsh.nix
        ../home/hyprland.nix
        ../home/hypr-swap-escape.nix
        ../home/inhibit-hyprland.nix
        ../home/home.nix
      ];
      programs.foot.settings.main.font = lib.mkForce "monospace:size=12";
      home.stateVersion = "24.05";
    };
    useGlobalPkgs = true;
    extraSpecialArgs = { inherit inputs;};
    useUserPackages = true;
  #  sharedModules = [ inputs.anyrun.homeManagerModules.default ];
  };
  home-manager.backupFileExtension = "backup";
  programs.kdeconnect.enable = true;
  system.stateVersion = "24.05";
  nixpkgs.hostPlatform = "x86_64-linux";

  networking.hostName = "nixos-laptop";
  boot.loader.efi.efiSysMountPoint = lib.mkForce "/boot/efi";
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };

  environment.systemPackages = with pkgs; [
    usbutils
    pciutils
    sbctl
    inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
  ];
#  services.gvfs.enable = true; #for pcmanfm
#  programs.sway ={
#    enable = true;
#    extraPackages = with pkgs; [
#      swaylock-effects
#      swayidle
#      wofi
#      i3status-rust
#      grim 
#      slurp
#      ranger
#    ];
#  };
    programs.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };
  security.pam.services.jcw.kwallet = {
    enable = true;
    forceRun = true;
    package = pkgs.kdePackages.kwallet-pam;
  };
  nix.settings.trusted-users = [
    "jcw"
    "root"

  ];
  hardware.brillo.enable = true;
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  programs.dconf.enable = true;
}
