{ config, pkgs, ...}:

{
  home.packages = with pkgs; [ 
    libreoffice-fresh
    hunspell
    hunspellDicts.en-us
    vscode
    git
    gcc
    celluloid
  ];
  nixpkgs.config.allowUnfree = true;
}
