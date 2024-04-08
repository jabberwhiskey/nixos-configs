{pkgs, config, ...}:
{
  users.users.jcw = {
    isNormalUser = true;
    description = "jcw";
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "audio"
      "sound"
    ];
    useDefaultShell = true;
    shell = pkgs.zsh;
  };
  programs.zsh.enable = true;
}
