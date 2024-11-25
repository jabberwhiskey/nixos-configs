{
  description = "config for modular nixos systems";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    stable.url = "github:NixOS/nixpkgs/nixos-24.11";
    old-stable.url = "github:NixOS/nixpkgs/nixos-24.05"; #for intel-compute-runtime that changed, breaking jellyfin.
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
#      inputs.nixpkgs.follows = "nixpkgs";
    };
    rose-pine-hyprcursor.url = "github:ndom91/rose-pine-hyprcursor";
#    wayland-pipewire-idle-inhibit = {
#      url = "github:rafaelrc7/wayland-pipewire-idle-inhibit";
#      inputs.nixpkgs.follows = "nixpkgs";
#    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    stable,
    nixos-hardware,
    old-stable,
    hyprland,
#    wayland-pipewire-idle-inhibit,
    ...
  }: {
    nixosConfigurations = {
      nixos-laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
      	specialArgs = {inherit inputs;};
        modules = [
          ./hosts/nixos-laptop.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              };
          }
        ];
     };
     nixos-server = old-stable.lib.nixosSystem {
       system = "x86_64-linux";
       modules = [
         ./hosts/nixos-server.nix
   	   ];
       specialArgs = {inherit inputs;};
     };
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
       nix-desktop = nixpkgs.lib.nixosSystem {
         system = "x86_64-linux";
	       specialArgs = {inherit inputs;};
         modules = [
           ./hosts/nix-desktop.nix
           home-manager.nixosModules.home-manager
           {
             home-manager = {
               useGlobalPkgs = true;
               useUserPackages = true;
               users.jcw = {
                 imports = [
                   ./home/home.nix
		               ./home/inhibit-hyprland.nix
		               ./home/hyprland.nix
                   ./home/hm-dconf.nix
                 ];
                 home.stateVersion = "23.11";
               };
               extraSpecialArgs = {
               };
             };
           }
         ];
       };

    };
  };
}
