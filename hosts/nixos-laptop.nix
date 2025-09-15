{
  pkgs,
  config,
  lib,
  inputs,
  hyprland,
  ...
}:
{
  imports = [
    ../system/basic.nix
<<<<<<< HEAD
<<<<<<< HEAD
    ../system/fprint.nix
=======
>>>>>>> e1d11bc (cleaned up config)
=======
    ../system/fprint.nix
>>>>>>> e6b0881 (updated lockfile)
    ../system/hyprland.nix
    ../system/pam-u2f.nix
    ../system/lanzaboote.nix
    ../system/basic-stable.nix
    ../system/u2f.nix
    ../system/tailscale.nix
    ../system/hyprpam.nix
    ../system/qt.nix
    ../system/waydroid.nix
    ../system/intel-laptop.nix
    ../system/greetd.nix
    #../system/kernel-latest.nix
    ../system/kernel-zen.nix
    ../system/fonts.nix
    ../system/systemdboot.nix
    ../system/containers.nix
    ../hardware/hplaptop.nix
  ];
  home-manager = {
    users.jcw = {
      programs.zsh.shellAliases = {
        "update" = "sudo nixos-rebuild boot --flake ~/dev/nixos-configs#nixos-laptop --verbose";
        "test" = "sudo nixos-rebuild test --flake ~/dev/nixos-configs#nixos-laptop --verbose";
      };
      imports = [
        ../home/waybar.nix
        ../home/bash.nix
        ../home/hypridle-extra.nix
        ../home/nvim.nix
        ../home/zsh.nix
        ../home/hypr-swap-escape.nix
        ../home/home.nix
      ];
      programs.foot.settings.main.font = lib.mkForce "monospace:size=12";
      home.stateVersion = "24.05";
    };
    useGlobalPkgs = true;
    extraSpecialArgs = { inherit inputs; };
    useUserPackages = true;
  };

  home-manager.backupFileExtension = "backup";

  system.stateVersion = "24.05";

  nixpkgs.hostPlatform = "x86_64-linux";

  networking.hostName = "nixos-laptop";
  boot.loader.efi.efiSysMountPoint = lib.mkForce "/boot/efi";

  environment.systemPackages = with pkgs; [
    usbutils
    pciutils
    sbctl
<<<<<<< HEAD
<<<<<<< HEAD
    tor-browser
=======
>>>>>>> e1d11bc (cleaned up config)
=======
    tor-browser
>>>>>>> 6f9a7b7 (updated lockfile fixed rofi)
  ];
  #  services.gvfs.enable = true; #for pcmanfm
  programs.dconf.enable = true;
}
