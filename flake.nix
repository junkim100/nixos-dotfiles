{
  description = "Home Manager configuration of junkim100";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs{
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
    in
    {
    
      nixosConfigurations = {
        "jun-desktop" = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs system; };

          modules = [
          ./configuration.nix
          ];
        };
      };

    };
}
