{pkgs, inputs, config, ...}: {
  fonts.packages = with inputs.stable.legacyPackages.x86_64-linux; [
    #    noto-fonts
    font-awesome
    fira-code
    fira-code-symbols
    dina-font
    nerdfonts
  ];
}
