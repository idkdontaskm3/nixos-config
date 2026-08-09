{ config, pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    ags
    android-tools
    ashell
    brightnessctl
    chromium
    cliphist
    dpkg
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
    hypridle
    hyprlock
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
    mako
    neovim
    nerd-fonts.fira-code
    nixfmt
    nvtopPackages.nvidia
    nwg-displays
    pavucontrol
    playerctl
    proton-vpn
    protonup-qt
    protonup-rs
    python3
    qbittorrent
    quickshell
    ripgrep
    rofi
    smartmontools
    solaar
    steam
    steam-run
    supertuxkart
    treefmt
    unzip
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
  services.wayle.enable = true;
  xdg.configFile."nvim/init.lua".source = ./nvim/init.lua;
}
