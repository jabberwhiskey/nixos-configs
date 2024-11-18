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
    shell = pkgs.fish;
    packages = with pkgs; [
      neovim
    ];
  };
  #programs.zsh.enable = true;
  programs.fish.enable = true;
  programs.git = {
    enable = true;
  };
}
