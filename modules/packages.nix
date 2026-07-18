{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    smartmontools
    cryptsetup
    btrfs-progs
    dosfstools
    ntfs3g
    efibootmgr
    curl
    wget
    steam-run
    pciutils
    mesa-demos
    fwupd
    bibata-cursors
    sbctl
    dmidecode
    pulseaudio
    vulkan-tools
    vulkan-loader
    linuxPackages.rtl8852au
    linuxPackages.rtl8852au
  ];
}
