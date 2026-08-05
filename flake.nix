{
  description = "Flake";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
  };
  outputs =
    inputs@{
      self,
      nixpkgs,
      nixpkgs-master,
      home-manager,
      ...
    }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system}.appendOverlays [(final: prev: {
        hyprland = nixpkgs-master.legacyPackages.${system}.hyprland;
      })];
    in
    {
      nixosConfigurations = {
        craptop = lib.nixosSystem {
          inherit system;
          modules = [ 
            ./configuration.nix
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
