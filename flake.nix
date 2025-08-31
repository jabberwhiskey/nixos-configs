{
  description = "config for modular nixos systems";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
<<<<<<< HEAD
=======
    mesa-downgrade.url = "github:NixOS/nixpkgs/a683adc19ff5228af548c6539dbc3440509bfed3"; # for gamescope, it breaks on mesa 25.2
>>>>>>> e1d11bc (cleaned up config)
    stable.url = "github:NixOS/nixpkgs/nixos-25.05";
    nix-bitcoin = {
      url = "github:fort-nix/nix-bitcoin/release";
      inputs.nixpkgs.follows = "stable";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    jovian = {
      url = "github:Jovian-Experiments/Jovian-NixOS";
    };
    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    };
    rose-pine-hyprcursor.url = "github:ndom91/rose-pine-hyprcursor";
    wayland-pipewire-idle-inhibit = {
      url = "github:rafaelrc7/wayland-pipewire-idle-inhibit";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    anyrun = {
      url = "github:anyrun-org/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nix-bitcoin,
      nixpkgs,
      home-manager,
      stable,
      nixos-hardware,
      lanzaboote,
      hyprland,
      anyrun,
<<<<<<< HEAD
=======
      mesa-downgrade, # for gamescope
>>>>>>> e1d11bc (cleaned up config)
      jovian,
      ...
    }:
    {
      nixosConfigurations = {
        #beater laptop
        nixos-laptop = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/nixos-laptop.nix
            home-manager.nixosModules.home-manager
            lanzaboote.nixosModules.lanzaboote
          ];
        };
        #node
        small-server = stable.lib.nixosSystem {
          modules = [
            ./hosts/small-server.nix
            nix-bitcoin.nixosModules.default
            (nix-bitcoin + /modules/presets/secure-node.nix)
            (nix-bitcoin + /modules/presets/wireguard.nix)
            (nix-bitcoin + /modules/presets/hardened.nix)
          ];
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
        };
        #media server/nas
        nixos-server = stable.lib.nixosSystem {
          modules = [
            ./hosts/nixos-server.nix
          ];
          specialArgs = { inherit inputs; };
        };
        #Framework Laptop
        framework = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/framework.nix
            home-manager.nixosModules.home-manager
            nixos-hardware.nixosModules.framework-amd-ai-300-series
            lanzaboote.nixosModules.lanzaboote
<<<<<<< HEAD
=======
            { hardware.graphics.package = inputs.mesa-downgrade.legacyPackages.x86_64-linux.mesa; } # gamescope breaks on updated mesa
>>>>>>> e1d11bc (cleaned up config)
          ];
        };
        #Desktop
        nix-desktop = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/nix-desktop.nix
<<<<<<< HEAD
=======
            { hardware.graphics.package = inputs.mesa-downgrade.legacyPackages.x86_64-linux.mesa; } # for gamescope
>>>>>>> e1d11bc (cleaned up config)
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
              };
            }
          ];
        };
        gpdwin = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/gpd.nix
            home-manager.nixosModules.home-manager
            jovian.nixosModules.default
          ];
        };
      };
      #Home-manager configurations
      homeConfigurations = {
        "jcw@linainverse" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs self; };
          modules = [
            ./hosts/linainverse.nix
          ];
        };
      };
    };
}
