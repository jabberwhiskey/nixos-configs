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
      chromium
<<<<<<< HEAD
      lazygit
      discord
      discordo
=======
      #      fluffychat
      discord
      discordo
      #      kdePackages.kasts
>>>>>>> e1d11bc (cleaned up config)
      mumble
      mpv
      htop
      bitwarden
      wiki-tui
      ytermusic
      iamb
      goread
      nix-inspect
<<<<<<< HEAD
=======
      neonmodem
      #      jellyfin-tui
>>>>>>> e1d11bc (cleaned up config)
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
      #      IMAGE_VIEWER = "qview";
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
