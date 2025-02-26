{ config, ... }:
{
xdg.configFile.nvim = {
  enable = true;
  recursive = true;
  source = ../extra/nvim;
  };
}
