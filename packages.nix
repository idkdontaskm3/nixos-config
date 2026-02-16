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
    unzip
    protonvpn-gui
    htop
    ripgrep
    ffmpeg
  ];
  nixpkgs.config.allowUnfree = true;
}
