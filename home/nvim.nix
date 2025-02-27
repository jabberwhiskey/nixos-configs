{ pkgs, config, ... }:
{
xdg.configFile.nvim = {
  enable = true;
  recursive = true;
  source = ../extra/nvim;
  };
  programs.neovim = {
    enable = true;
    plugins = [
      pkgs.vimPlugins.telescope-nvim
      pkgs.vimPlugins.plenary-nvim
      pkgs.vimPlugins.nvim-treesitter
    ];
  };
}
