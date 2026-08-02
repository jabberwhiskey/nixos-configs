{
  config,
  pkgs,
  ...
}:
{
  home = {
    enableNixpkgsReleaseCheck = false;
    username = "jcw";
    homeDirectory = "/home/jcw";
    packages = with pkgs; [
      btop
      yazi
      chromium
      lazygit
      discordo
      mumble
      mpv
      htop
#      bitwarden-desktop
      wiki-tui
      ytermusic
      nix-inspect
      bitwarden-cli
      firefox
      browsh
      unzip
      yt-dlp
      ffmpeg
      imv
    ];
    sessionVariables = {
      SHELL = "${pkgs.zsh}/bin/zsh";
      MANPAGER = "nvim +Man!";
      BROWSER = "firefox";
      IMAGE_VIEWER = "imv";
    };
  };
  xdg = {
    enable = true;
    portal.xdgOpenUsePortal = true;
  };
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "jcw";
        email = "github.u9l99@aleeas.com";
      };
    };
  };
  imports = [
    ./tmux.nix
  ];
  services.udiskie = {
    enable = true;
    automount = true;
    notify = true;
    settings = {
      program_options = {
        udisks_version = 2;
        tray = "auto";
      };
      icon_names.media = [ "drive-removable-media-usb" ];
    };
  };
}
