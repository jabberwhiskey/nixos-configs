{
  description = "config for modular nixos systems";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    stable.url = "github:NixOS/nixpkgs/nixos-24.11";
    nix-bitcoin = {
      url = "github:fort-nix/nix-bitcoin/release";
      inputs.nixpkgs.follows = "stable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    };
    rose-pine-hyprcursor.url = "github:ndom91/rose-pine-hyprcursor";
  };

  outputs = inputs @ {
    self,
    nix-bitcoin,
    nixpkgs,
    home-manager,
    stable,
    nixos-hardware,
    hyprland,
    ...
  }: {
    nixosConfigurations = {
#beater laptop
#      nixos-laptop = stable.lib.nixosSystem {
      nixos-laptop = nixpkgs.lib.nixosSystem {
      	specialArgs = {inherit inputs;};
        modules = [
          ./hosts/nixos-laptop.nix
          home-manager.nixosModules.home-manager
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
       specialArgs = {inherit inputs;};
     };
#media server/nas
     nixos-server = stable.lib.nixosSystem {
       modules = [
         ./hosts/nixos-server.nix
   	   ];
       specialArgs = {inherit inputs;};
     };
#Framework Laptop
     framework = nixpkgs.lib.nixosSystem {
       system = "x86_64-linux";
	     specialArgs = {inherit inputs;};
        modules = [
          ./hosts/framework.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
            };
         }
          nixos-hardware.nixosModules.framework-11th-gen-intel
        ];
       };
#Desktop
       nix-desktop = nixpkgs.lib.nixosSystem {
	       specialArgs = {inherit inputs;};
         modules = [
           ./hosts/nix-desktop.nix
           home-manager.nixosModules.home-manager
           {
             home-manager = {
               useGlobalPkgs = true;
               useUserPackages = true;
             };
           }
         ];
       };
    };
#Home-manager configurations
    homeConfigurations = {
      "jcw@craptop" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs self;};
        modules = [
          ./hosts/craptop.nix
        ];
      };
      "jcw@linainverse" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        #pkgs = nixpkgs.legacyPackages.${system};
	system = "x86_`64-linux";
        extraSpecialArgs = {inherit inputs self;};
        modules = [
          ./hosts/linainverse.nix
        ];
      };
    };
  };
}
