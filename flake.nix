{
  description = "NixOS configuration of junkim100";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    firefox-addons,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    color-palette = import ./modules/nordtheme.nix;
  in {
    nixosConfigurations."jun-desktop" = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs system;};
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {inherit color-palette firefox-addons;};
          home-manager.users.junkim100 = import ./home.nix;
        }
      ];
    };
  };
}
