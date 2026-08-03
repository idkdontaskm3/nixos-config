{ config, pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    ags
    android-tools
    ashell
    brightnessctl
    cliphist
    dpkg
    ffmpeg
    fzf
    gamemode
    gcc
    gh
    gimp
    git
    gitbutler
    glow
    gnome-shell
    gparted
    hunspell
    hunspellDicts.en-us
    hypridle
    hyprlock
    hyprpaper
    hyprpolkitagent
    hyprshot
    innoextract
    ipscan
    jq
    kicad
    kitty
    libnotify
    libreoffice-fresh
    lm_sensors
    mako
    micro
    neovim
    nerd-fonts.fira-code
    nixfmt
    nvtopPackages.nvidia
    nwg-displays
    pavucontrol
    plank
    proton-vpn
    protonup-qt
    protonup-rs
    python3
    qbittorrent
    quickshell
    ripgrep
    rofi
    rpi-imager
    solaar
    steam
    steam-run
    unzip
    vscode
    waybar
    wev
    wireshark
    wl-clipboard
    wlogout
    xwayland
  ];
  imports = [ inputs.zen-browser.homeModules.default ];
  services.wayle.enable = true;
  programs.zen-browser.enable = true;
  nixpkgs.config.allowUnfree = true;
  programs.neovim.enable = false;
  xdg.configFile."nvim/init.lua".source = ./nvim/init.lua;
}
