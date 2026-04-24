{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # -- Bootloader & Kernel --
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelModules = [ "legion-laptop" "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.lenovo-legion-module ];
  boot.kernelParams = [
    "nvme_core.default_ps_max_latency_us=0"
    "pcie_aspm=off"
    "ideapad_laptop.allow_v4_dytc=1"
    "nvidia-drm.modeset=1"
  ];

  # -- Graphics & NVIDIA Drivers --
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidia_x11_legacy470;
    modesetting.enable = true;
    powerManagement.enable = false;
    open = false;
    prime = {
      sync.enable = true;
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  # -- Desktop Environments & Display --
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    displayManager.lightdm.enable = true;
    desktopManager.cinnamon.enable = true;
  };

  services.displayManager.cosmic-greeter.enable = false;
  services.desktopManager.cosmic.enable = true;

  # -- Networking & Localization --
  networking.hostName = "craptop";
  networking.networkmanager.enable = true;
  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";

  # -- Hardware Services & Udev --
  services.printing.enable = true;
  hardware.bluetooth.enable = true;
  security.rtkit.enable = true;
  
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.udev.extraRules = ''
    SUBSYSTEM=="platform", DRIVERS=="legion-laptop", MODE="0666"
    SUBSYSTEM=="hwmon", ATTRS{name}=="legion_laptop", MODE="0666"
    SUBSYSTEM=="platform", DRIVERS=="ideapad_acpi", MODE="0666"
  '';

  # -- User Configuration --
  users.users.ryan = {
    isNormalUser = true;
    description = "Ryan";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
    packages = with pkgs; [ ];
  };

  # -- System Packages --
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
    steam-run
    pciutils
    mesa-demos
  ];

  # -- Programs & Gaming --
  programs.firefox.enable = true;
  services.flatpak.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  # -- Nix Settings & State --
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.nvidia.acceptLicense = true;
  system.stateVersion = "26.05";
}
