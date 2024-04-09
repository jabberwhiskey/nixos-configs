{pkgs, config, ... }:
{
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "${pkgs.hyprland}/bin/Hyprland";
        user = "jcw";
      };
      default_session = initial_session;
    };
  };

}
