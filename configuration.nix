{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # --- Nvidia Drivers ---
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "modesetting" "nvidia" ];
  hardware.nvidia.open = true;

  # --- Flakes & Nix Settings ---
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  # --- Boot & System Core ---
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # --- Drive & Storage ---
  boot.kernelParams = [ 
    "nvme_core.default_ps_max_latency_us=0" 
    "pcie_aspm=off"
    "ideapad_laptop.allow_v4_dytc=1"
  ];

  # --- Lenovo Legion Support (Driver & Permissions) ---
  boot.extraModulePackages = [
    config.boot.kernelPackages.lenovo-legion-module
  ];
  
  boot.kernelModules = [ "legion-laptop" ];
  services.udev.extraRules = ''
    SUBSYSTEM=="platform", DRIVERS=="legion-laptop", MODE="0666"
    SUBSYSTEM=="hwmon", ATTRS{name}=="legion_laptop", MODE="0666"
    SUBSYSTEM=="platform", DRIVERS=="ideapad_acpi", MODE="0666"
  '';

  # --- Networking ---
  networking.hostName = "craptop";
  networking.networkmanager.enable = true;

  # --- Localization ---
  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";

  # --- Desktop Environment ---
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
    fwupd
    smartmontools
    cryptsetup
    btrfs-progs
    dosfstools
    ntfs3g
    efibootmgr
    curl
    wget
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  system.stateVersion = "26.05";
}
