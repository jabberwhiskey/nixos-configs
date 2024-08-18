{pkgs, inputs, config, pkgsStable,  ...}: {
   # fonts fail to etch sometimes
  _module.args.pkgsStable = import inputs.stable {
    inherit (pkgs.stdenv.hostPlatform) system;
    inherit (config.nixpkgs) config;
  };
  fonts.packages = with pkgsStable; [
    #    noto-fonts
    font-awesome
    fira-code
    fira-code-symbols
    dina-font
    nerdfonts
  ];
}
