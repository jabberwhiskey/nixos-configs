{
  # suspend to RAM (deep) rather than `s2idle`
  boot.kernelParams = [ "mem_sleep_default=deep" ];
  # suspend-then-hibernate
  systemd.sleep.extraConfig = ''
    HibernateDelaySec=45m
    SuspendState=mem
  '';

}
