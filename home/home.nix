{ config, pkgs, inputs, glaze-stable, system, ... }:

{
  imports = [
    ./zsh.nix
    ./packages.nix
    ./fish.nix
    ./noctalia.nix
  ];

  # hyprland patch, no longer needed when hyprland updates for glaze 8

  nixpkgs.config.packageOverrides = pkgs: {
    glaze = glaze-stable.legacyPackages.${system}.glaze;
  };  

  home.username = "ryan";
  home.homeDirectory = "/home/ryan";
  home.stateVersion = "26.05";
  programs.home-manager.enable = true;
}
