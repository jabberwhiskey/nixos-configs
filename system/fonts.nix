{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
#    noto-fonts
    font-awesome
    fira-code
    fira-code-symbols
    dina-font
    nerdfonts
  ];
}
