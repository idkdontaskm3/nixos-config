{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bibata-cursors
    btrfs-progs
    cryptsetup
    curl
    dmidecode
    dosfstools
    efibootmgr
    mesa-demos
    pciutils
    pulseaudio
    sbctl
    sddm-sugar-dark
    smartmontools
    steam-run
    vulkan-loader
    vulkan-tools
    wget
  ];
}
