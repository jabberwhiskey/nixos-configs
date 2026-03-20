{
  pkgs,
  inputs,
  config,
  ...
}:
{
  fonts = {
    packages = with inputs.stable.legacyPackages.${pkgs.system}; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      font-awesome
      fira-code-symbols
      dina-font
      nerd-fonts.noto
      nerd-fonts.ubuntu
      nerd-fonts._0xproto
      nerd-fonts.fira-code
      ubuntu-sans
      ubuntu-classic
      ubuntu-sans-mono
    ];
  };
}
