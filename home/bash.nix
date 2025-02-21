{ pkgs, config, ... }:
{
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
    shellAliases = {
      "ll" = "ls -l";
      "la" = "ls -la";
      ".." = "cd ..";
    };
    profileExtra = ''
      export PATH=$PATH:/var/lib/flatpak/exports/bin
    '';
    enableCompletion = true;
  };
}
