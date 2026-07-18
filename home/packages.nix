{ config, pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    micro
    nerd-fonts.fira-code
    gparted
    libreoffice-fresh
    hunspell
    hunspellDicts.en-us
    vscode
    git
    gcc
    unzip
    proton-vpn
    ripgrep
    ffmpeg
    qbittorrent
    nvtopPackages.nvidia
    android-tools
    fzf
    waybar
    rofi
    hyprpolkitagent
    hyprlock
    hypridle
    hyprpaper
    hyprshot
    cliphist
    pavucontrol
    kitty
    nwg-displays
    mako
    libnotify
    wl-clipboard
    wev
    wlogout
    lm_sensors
    plank
    quickshell
    xwayland
    innoextract
    gimp
    solaar
    nixfmt
    steam
    steam-run
    ags
    ashell
    kicad
    jq
    rpi-imager
    gamemode
    plank
    nwg-dock-hyprland
  ];
  imports = [ inputs.zen-browser.homeModules.default ];
  services.wayle.enable = true;
  programs.zen-browser.enable = true;
  nixpkgs.config.allowUnfree = true;
}
