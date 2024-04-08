{
  services.greetd {
    enable = true;
    settings = rec {
      command = "${pkgs.hyprland}/bin/Hyprland";
      user = "jcw";
    };
    default_session = initial_session;
  };

}
