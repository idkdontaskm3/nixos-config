{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/boot.nix
    ./modules/nix-settings.nix
    ./modules/security.nix
    ./modules/networking.nix
    ./modules/swap.nix
    ./modules/graphics.nix
    ./modules/desktop.nix
    ./modules/services.nix
    ./modules/users.nix
    ./modules/programs.nix
    ./modules/packages.nix
    ./pkgs/rtl8852au.nix
  ];

  system.stateVersion = "26.05";
}
