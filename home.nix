{ config, pkgs, inputs, ... }:

{
  imports = [
    ./zsh.nix
    ./packages.nix
    ./fish.nix
  ];

  home.username = "ryan";
  home.homeDirectory = "/home/ryan";
  home.stateVersion = "26.05";
  programs.home-manager.enable = true;
}
