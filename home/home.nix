{
  config,
  pkgs,
  ...
}: {
  home = {
    username = "jcw";
    homeDirectory = "/home/jcw";
    packages = with pkgs; [
      btop
      chromium
      kdePackages.kasts
      mumble
      mpv
      htop
      imv
      bitwarden
      iamb
      bitwarden-cli
      firefox
      #vivaldi
      unzip
      yt-dlp
      ffmpeg
      qutebrowser
    ];
    sessionVariables = {
#      SHELL = "${pkgs.zsh}/bin/zsh";
    };
  };
  xdg = {
    enable = true;
    portal.xdgOpenUsePortal = true;
  };
  programs.bash = {
    enable = true;
    historyControl = [ "erasedups" ];
    historySize = 1000;
    shellOptions = [
      "histappend"
      "checkwinsize"
      "extglob"
      "globstar"
      "checkjobs"
    ];
    historyIgnore = [
      "ls"
      "exit"
    ];
    initExtra = ''
      # Load __git_ps1 bash command.
      # Optional: Also load git command completions for bash.
      source /run/current-system/sw/share/bash-completion/completions/git-prompt.sh
      # Show working directory and git branch status in terminal shell.
      # Customize as desired for your shell prompt preferences.
      export PS1='\w> $(__git_ps1 "(%s)") \$> '
      GIT_PS1_SHOWDIRTYSTATE=1

      export LS_COLORS=$LS_COLORS:'di=1;36:'
    '';
    enableCompletion = true;


  };
  programs.git = {
    enable = true;
    userName = "jcw";
    userEmail = "jwillbanks2@gmail.com";
  };
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    history.expireDuplicatesFirst = true;
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    antidote = {
      enable = true;
      plugins = [
        "lonr/ghoti"
        "marlonrichert/zsh-autocomplete"
        "agnoster/agnoster-zsh-theme" #seems to be gone?
        "davidde/git"
      ];
    };

    initExtra = ''
      setopt NO_NOMATCH
    '';
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
