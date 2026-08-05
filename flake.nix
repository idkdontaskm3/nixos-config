{
  description = "Flake";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    glaze-stable.url = "github:NixOS/nixpkgs/nixos-26.05";
  };
  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      glaze-stable,
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
              nixpkgs.config.packageOverrides = pkgs: {
                  glaze = glaze-stable.legacyPackages.${system}.glaze;
              };
            }
          ];
        };
      };
      homeConfigurations = {
        ryan = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { 
            inherit inputs system;
            glaze-stable = inputs.glaze-stable;
          };
          modules = [ 
            ./home/home.nix
          ];
        };
      };
    };
}
