{ config, pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    ags
    android-tools
    ashell
    brightnessctl
    cachix
    cliphist
    ffmpeg
    fzf
    gamemode
    gcc
    gh
    gimp
    git
    gparted
    hunspell
    hunspellDicts.en-us
    hyprpaper
    hyprpolkitagent
    hyprshot
    ipscan
    jq
    kicad
    kitty
    libnotify
    libreoffice-fresh
    lm_sensors
    lumafly
    mako
    mpv
    mtkclient
    neovim
    nerd-fonts.fira-code
    nixfmt
    nwg-displays
    pavucontrol
    playerctl
    proton-vpn
    protonup-qt
    protonup-rs
    python3
    qbittorrent
    quickshell
    rofi
    smartmontools
    steam
    steam-run
    unzip
    usbutils
    vlc
    wev
    wl-clipboard
    wlogout
    xwayland
  ];
  imports = [ inputs.zen-browser.homeModules.default ];
  nixpkgs.config.allowUnfree = true;
  programs.neovim.enable = false;
  programs.zen-browser.enable = true;
  xdg.configFile."nvim/init.lua".source = ./nvim/init.lua;
}
