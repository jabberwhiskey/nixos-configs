 { config, pkgs, ... }:
 {
 programs.gnupg.agent = {
     enable = true;
     enableSSHSupport = true;
 };
 security.pam.services = {
     login.u2fAuth = true;
     sudo.u2fAuth = true;
 };
 environment.systemPackages = [
  pkgs.solo2-cli
 ];
 # https://github.com/solokeys/solo2-cli/blob/main/70-solo2.rules
 services.udev.packages = [
     pkgs.yubikey-personalization
 ];
 security.pam.yubico = {
   enable = true;
   debug = true;
   mode = "challenge-response";
  # id = [ "12345678" ];
};
services.pcscd.enable = true;
}


