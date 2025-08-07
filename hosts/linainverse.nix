{ home-manager, pkgs, config, inputs, lib, ... }:
{
  imports = [
    ../home/sway.nix
    ../home/bash.nix
    ../home/sway-inhibit.nix
    ../home/zsh.nix
    ../home/nvim.nix
#    ../home/home.nix
  ];
  nixpkgs.config = {
    allowUnfree = true;
  };
  home = {
    username = "jcw";
    homeDirectory = "/home/jcw";
  };
  #wayland.windowManager.sway.package =  pkgs.emptyFile;
  wayland.windowManager.sway.package =  null;
  programs.git = {
    enable = true;
    userName = "jcw";
    userEmail = "github.u9l99@aleeas.com";
  };
  programs.home-manager.enable = true;
  xdg = {
    enable = true;
    portal.xdgOpenUsePortal = true;
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
      	font = "monospace:size=12";
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
      chromium
      discord
      discordo
      mumble
      htop
      bitwarden
      wiki-tui
      ytermusic
      russ
      iamb
      nix-inspect
      neonmodem
#      jellyfin-tui
      bitwarden-cli
      firefox
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
}

