{ pkgs, config, lib, inputs, ... }:
{
  nixpkgs = {
    hostPlatform = "x86_64-linux";
  };
  imports = [
    ../hardware/gpd.nix
    ../user/user.nix
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
        ../home/zsh.nix
      ];
    home.stateVersion = "23.05";
    };
  };
#  specialArgs = { inherit inputs; };
  system.stateVersion = "25.05";
  jovian = {
    steam = {
      autoStart = true;
      enable = true;
      desktopSession = "plasmawayland";
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
  };
  services.displayManager.sddm.settings = {
    enable = lib.mkForce false;
    Autologin = {
      Session = "gamescope-wayland.desktop";
      User = "jcw";
    };
    loader.plymouth.enable = true;
  };
  powerManagement = {
  enable = true;
  };
  networking.hostName = "gpdwin";
}
