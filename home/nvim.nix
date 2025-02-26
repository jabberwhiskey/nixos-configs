{ config, ... }:
{
xdg.configFile.nvim = {
  recursive = true;
  source = ../extra/nvim;
  };
}
