{
  description = "Flake";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };
  outputs =
    inputs@{
      self,
      nixpkgs,
      nixpkgs-stable,
      home-manager,
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
            {
              nixpkgs.overlays = [(final: prev: {
                rtl8852au = nixpkgs-stable.legacyPackages.${system}.rtl8852au;
              })];
            }
          ];
        };
      };
      homeConfigurations = {
        ryan = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs; };
          modules = [ ./home/home.nix ];
        };
      };
    };
}
