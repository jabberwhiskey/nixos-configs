{
  pkgs,
  config,
  nix-bitcoin,
  ...
}:
{
  services.bitcoind = {
    enable = true;
  };
  nix-bitcoin = {
    onionServices = {
      bitcoind.public = true;
      lnd.public = true;
    };
    generateSecrets = true;
  };
  services.lnd = {
    enable = true;
    lndconnect = {
      enable = true;
      onion = true;
    };
  };
  services.mempool.enable = true;
  nix-bitcoin.onionServices.mempool-frontend.enable = true;
  services.electrs.enable = true;
  services.liquidd.enable = true;
  services.charge-lnd.enable = true;
  services.backups.enable = true;
  nix-bitcoin.useVersionLockedPkgs = true;
  nix-bitcoin.operator = {
    enable = true;
    name = "jcw";
  };
}
