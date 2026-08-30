{
  description = "Flake";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    noctalia.url = "github:noctalia-dev/noctalia?rev=62bbfa1d229bf0351e8ac18d9bdfaeb5fb00fa9e;
  };
  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      chaotic,
      ...
    }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system}; 
    in
    {
    nixosConfigurations = {
      craptop = lib.nixosSystem {
        inherit system;
        modules = [ 
          ./configuration.nix
          chaotic.nixosModules.default
        ];
      };
    };
    homeConfigurations = {
      ryan = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { 
          inherit inputs system;
        };
        modules = [ 
          ./home/home.nix
        ];
      };
    };
  };
}
