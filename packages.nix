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
    proton-vpn
    htop
    ripgrep
    ffmpeg
    lenovo-legion
    ulauncher
    qbittorrent
    nvtopPackages.nvidia
    lsfg-vk
    lsfg-vk-ui
  ];
  nixpkgs.config.allowUnfree = true;
}
