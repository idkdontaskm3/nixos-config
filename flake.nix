{
  description = "Flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-openclaw.url = "github:openclaw/nix-openclaw";
  };

  # 1. Add nix-openclaw to the outputs arguments
  outputs = { self, nixpkgs, home-manager, nix-openclaw, ... }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations = {
        craptop = lib.nixosSystem {
          inherit system;
          # 2. Pass the input into specialArgs so configuration.nix can see it
          specialArgs = { inherit nix-openclaw; }; 
          modules = [ ./configuration.nix ];
      };
    };
    homeConfigurations = {
      ryan = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        # 3. Pass the input into extraSpecialArgs for home.nix
        extraSpecialArgs = { inherit nix-openclaw; };
        modules = [ ./home.nix ];
      };
    };
  };
}
