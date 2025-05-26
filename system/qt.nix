{pkgs, config, ...}:
{
  config ={
    qt = {
      enable = true;
      style = "adwaita-dark";
      platformTheme = "qt6ct";

    };
  };
}
