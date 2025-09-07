{ pkgs, config, ... }:
{
  services.fprintd.enable = true;
  security.pam.services = {
    sudo.fprintAuth = true;
    polkit-1.fprintAuth = true;
#login for greetd
    greetd.fprintAuth = true;
    login.fprintAuth = true;
  };
}
