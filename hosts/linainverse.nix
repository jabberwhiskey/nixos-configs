{
  home-manager,
  pkgs,
  config,
  inputs,
  lib,
  ...
}:
{
  imports = [
    ../home/sway.nix
    ../home/bash.nix
    ../home/sway-inhibit.nix
    ../home/zsh.nix
    ../home/nvim.nix
    ../home/hyprland.nix
    ../home/hypr-swap-escape.nix
    ../home/waybar.nix
    ../home/inhibit-hyprland.nix
  ];
  nixpkgs.config = {
    allowUnfree = true;
  };
  home = {
    username = "jcw";
    homeDirectory = "/home/jcw";
  };
  wayland.windowManager.sway.package = null;
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "jcw";
        email = "github.u9l99@aleeas.com";
      };
    };
  };
  programs.home-manager.enable = true;
  xdg = {
    enable = true;
    portal.xdgOpenUsePortal = true;
    mimeApps.defaultApplications = {
      "image/jpeg" = "imv.desktop";
      "image/png" = "imv.desktop";
      "image/gif" = "imv.desktop";

    };
    systemDirs.data = [
      "/var/lib/flatpak/exports/share"
      "/home/jcw/.local/share/flatpak/exports/share"
    ];
  };
  home.stateVersion = "24.11";
  targets.genericLinux.enable = true;
  programs.foot = {
    enable = true;
    #    package = null;
    settings = {
      main = {
        app-id = "foot";
        font = lib.mkForce "monospace:size=12";
      };
      colors = {
        alpha = 0.9;
        background = "242424";
        foreground = "ffffff";
      };
    };
  };
  nix = {
    gc = {
      automatic = true;
    };
  };
  home = {
    enableNixpkgsReleaseCheck = false;
    packages = with pkgs; [
      btop
      discordo
      imv
      mumble
      htop
      bitwarden-cli
      wiki-tui
      ranger
      ytermusic
      russ
      iamb
      nix-inspect
      neonmodem
      browsh
      unzip
      yt-dlp
    ];
    sessionVariables = {
      SHELL = "${pkgs.zsh}/bin/zsh";
      MANPAGER = "nvim +Man!";
      BROWSER = "firefox";
      IMAGE_VIEWER = "imv";
      #      IMAGE_VIEWER = "qview";
    };
  };
  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
  };
  services.udiskie = {
    enable = true;
    automount = true;
    notify = true;
    settings = {
      program_options = {
        udisks_version = 2;
        tray = "auto";
        icon_names.media = [ "drive-removable-media-usb" ];
      };
    };
  };
  wayland.windowManager.hyprland = {
    package = lib.mkForce inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = lib.mkForce inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };
  programs.hyprlock.enable = lib.mkForce false; #cant get pam to work with home-manager hyprlock
  services.hypridle.settings.listener = [{
    timeout = 900;
    on-timeout =  "/bin/swaylock -i ${config.home.homeDirectory}/Pictures/Wallpapers/wallpaper2.png -s fill";
  }];
}
