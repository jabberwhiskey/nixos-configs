{
  pkgs,
  config,
  ...
}: {
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
    shell = pkgs.bash;
    packages = with pkgs; [
      neovim
      neomutt
      yadm
      nvtop
    ];
  };
  #programs.zsh.enable = true;
  programs.bash.completion.enable = true;
  programs.git = {
    enable = true;
    prompt.enable = true;
  };
}
