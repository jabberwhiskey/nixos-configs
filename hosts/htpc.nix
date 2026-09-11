
{ config, inputs, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ../hardware/htpc.nix
      ../system/systemd-tailscale.nix
      ../system/fonts.nix
      ../system/bluetooth.nix
      ../system/kernel-latest.nix
      ../system/systemdboot.nix
      ../system/steam.nix
      ../system/tailscale.nix
      ../system/basic.nix
      ../system/plasma.nix
    ];
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.jcw = {
      home.stateVersion = "25.05";
      programs.kodi = {
        enable = true;
        package = pkgs.kodi-wayland.withPackages (kodiPkgs: with kodiPkgs; [
		      jellyfin
          youtube
          upnext
          inputstreamhelper
          keymap
          osmc-skin
	      ]);
      };
    };
    users.jcw = {
      imports = [
        ../home/bash.nix
        ../home/home.nix
      ];
    };
  };
  xdg.portal.configPackages = [ pkgs.kdePackages.plasma-bigscreen ];
  security.pam.services.jcw.kwallet.enable = true;
  services.displayManager = {
    autoLogin = {
      enable = true;
      user = "jcw";
    };
    defaultSession = "plasma-bigscreen-wayland";
    sessionPackages = [ pkgs.kdePackages.plasma-bigscreen ];
    sddm = {
      autoLogin.relogin = true;
    };
  };
  nixpkgs.overlays = [
    (final: prev: {
       kdePackages = prev.kdePackages // {
          plasma-bigscreen = prev.kdePackages.plasma-bigscreen.overrideAttrs (old: {
              buildInputs = (old.buildInputs or [ ]) ++ [ prev.kdePackages.kdeconnect-kde ];  
              preFixup = ''
                  wrapQtApp $out/bin/plasma-bigscreen-wayland \
                    --prefix QML2_IMPORT_PATH : "${prev.kdePackages.kdeconnect-kde}/lib/qt-6/qml"
                '';
            });
        };
    })
];
  users.users.jcw.openssh.authorizedKeys.keyFiles = [
    ../user/keys
  ];
  environment.systemPackages = [
    inputs.stable.legacyPackages.${pkgs.system}.retroarch-free
    pkgs.kdePackages.plasma-bigscreen
  ];
   hardware = {
    steam-hardware.enable = true;
    bluetooth.enable = true;
    xone.enable = true;
  };
  networking.hostName = "htpc";
  nixpkgs = {
    hostPlatform = "x86_64-linux";
  };
  system.stateVersion = "25.05";
}
