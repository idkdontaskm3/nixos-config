{ config, pkgs, ... }:

{
  imports = [
    ./bash.nix
    ./packages.nix
    ./hyprland.nix
  ];

  home.username = "ryan";
  home.homeDirectory = "/home/ryan";
  home.stateVersion = "25.11";
  programs.home-manager.enable = true;
}
