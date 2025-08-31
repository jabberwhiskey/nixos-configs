{ pkgs, config, lib, inputs, ... }:
{
  nixpkgs = {
    hostPlatform = "x86_64-linux";
  };
  imports = [
    ../hardware/gpd.nix
    ../system/kernel-latest.nix
    ../system/basic.nix
    ../system/fonts.nix
    ../system/systemdboot.nix
    ../system/tailscale.nix
    ../system/containers.nix
    ../system/plasma.nix
    ../system/steam.nix
  ];
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs;};
    users.jcw = {
      imports = [
        ../home/home.nix
        ../home/bash.nix
        ../home/zsh.nix
      ];
      programs.zsh.shellAliases = { 
        "update" = "sudo nixos-rebuild boot --flake github:jabberwhiskey/nixos-configs#gpdwin --verbose";
        "test" = "sudo nixos-rebuild test --flake github:jabberwhiskey/nixos-configs#gpdwin --verbose";
      };
   home.stateVersion = "23.05";
    };
  };
#  specialArgs = { inherit inputs; };
  system.stateVersion = "25.05";
  jovian = {
    steam = {
      user = "jcw";
      autoStart = true;
      enable = true;
      desktopSession = "plasma";
    };
    steamos = {
      useSteamOSConfig = true;
      enableAutoMountUdevRules = true;
      enableBluetoothConfig = true;
    };
    hardware.has.amd.gpu = true;
  };
  boot = {
    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "amd_pstate=active"
      "logLevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
    plymouth.enable = true;
  };
  services.displayManager.sddm = {
    enable = lib.mkForce false;
    settings = {
      Autologin = {
        Session = "gamescope-wayland.desktop";
        User = "jcw";
      };
    };
  };
  powerManagement = {
  enable = true;
  };
  networking.hostName = "gpdwin";
}
