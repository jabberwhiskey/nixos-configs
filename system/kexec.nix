{
  systemd.services."prepare-kexec" = {
    wantedBy= [ "multi-user.target" ];
    enable = true;
  };
}
