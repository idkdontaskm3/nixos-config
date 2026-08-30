{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    smartmontools
    cryptsetup
    btrfs-progs
    dosfstools
    efibootmgr
    curl
    wget
    steam-run
    pciutils
    mesa-demos
    bibata-cursors
    sbctl
    dmidecode
    pulseaudio
    vulkan-tools
    vulkan-loader
  ];
}
