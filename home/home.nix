{ config, pkgs, inputs, system, ... }:

{
  imports = [
    ./zsh.nix
    ./packages.nix
    ./fish.nix
    ./noctalia/noctalia.nix
  ];

  home.username = "ryan";
  home.homeDirectory = "/home/ryan";
  home.stateVersion = "26.05";
  programs.home-manager.enable = true;
}
