{ pkgs, config, ... }:
{
  systemd.user.mounts = {
    home-jcw-mount = {
      Unit = {
        Description = "nfs mount";
        Documentaion = [ "man:nfs"; ];
      };
      Mount = {
        What = "100.85.215.105:/shared";
        Where = "/home/jcw/shared";
        Type = "nfs";
        LazyUnmount = true;
        TimeoutSec = 10;
        Options = "rw,user,nfsvers=4.2"
      };
    };
  };
  systemd.user.automounts = {
    home-jcw-shared = {
      Unit = {
        Description = "automount shared";
      };
      Automount = {
        Where = "/home/jcw/shared";
      };
      Install = {
        WantedBy = "multi-user.target"
      };
    };
  };

}
