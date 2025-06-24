{
  config,
  pkgs,
  ...
}: {
  home = {
    enableNixpkgsReleaseCheck = false;
    username = "jcw";
    homeDirectory = "/home/jcw";
    packages = with pkgs; [
      btop
      fractal
      chromium
      discord
      discordo
      kdePackages.kasts
      mumble
      mpv
      htop
      bitwarden
      iamb
      jellyfin-tui
#      bitwarden-cli
      firefox
      browsh
      unzip
      yt-dlp
      ffmpeg
#      qutebrowser
    ];
    sessionVariables = {
      SHELL = "${pkgs.zsh}/bin/zsh";
      MANPAGER = "nvim +Man!";
      BROWSER = "firefox";
      IMAGE_VIEWER = "qview";
    };
  };
  xdg = {
    enable = true;
    portal.xdgOpenUsePortal = true;
  };
  programs.git = {
    enable = true;
    userName = "jcw";
    userEmail = "github.u9l99@aleeas.com";
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
