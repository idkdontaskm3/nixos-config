{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # --- Flakes & Nix Settings ---
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  # --- Boot & System Core ---
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # --- Drive & Storage ---
  boot.initrd.luks.devices."luks-0acf8694-fcf9-4216-904a-652b8f7e56df".device = "/dev/disk/by-uuid/0acf8694-fcf9-4216-904a-652b8f7e56df";
  boot.kernelParams = [ 
  "nvme_core.default_ps_max_latency_us=0" 
  "pcie_aspm=off"
  ];

  # --- Networking ---
  networking.hostName = "craptop";
  networking.networkmanager.enable = true;

  # --- Localization ---
  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";

  # --- Desktop Environment (Cinnamon) ---
  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = true;
    desktopManager.cinnamon.enable = true;
    xkb.layout = "us";
  };

  # --- Hardware & Audio Services ---
  services.printing.enable = true;
  hardware.bluetooth.enable = true;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # --- User Configuration ---
  users.users.ryan = {
    isNormalUser = true;
    description = "Ryan";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
    packages = with pkgs; [

    ];
  };

  # --- System-Wide Packages ---
  programs.firefox.enable = true;
  environment.systemPackages = with pkgs; [
    protonvpn-gui
    fwupd
    smartmontools
    cryptsetup
    btrfs-progs
    dosfstools
    ntfs3g
    efibootmgr
    _7zz
    unzip
    htop
    curl
    wget
    ripgrep
    ffmpeg
  ];

  system.stateVersion = "25.11";
}
