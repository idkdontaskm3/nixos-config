{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # -- SSH & Build Servers --
  nix.distributedBuilds = true;

  nix.buildMachines = [
    {
      hostName = "192.168.68.89";
      sshUser = "nix-builder";
      sshKey = "/root/.ssh/nix_builder_key";
      systems = [ "x86_64-linux" ];
      maxJobs = 2;
      speedFactor = 1;
      supportedFeatures = [
        "nixos-test"
        "benchmark"
      ];
      mandatoryFeatures = [ ];
    }
  ];

  nix.settings.builders-use-substitutes = true;

  programs.ssh.knownHosts = {
    nixBuilder = {
      hostNames = [ "192.168.68.89" ];
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJaJ19mqm12R2dwPGk6rwrPBcEMbCVXcwETNTyEdx/I6 ";
    };
  };

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
  nix.settings.trusted-users = [ "root" "ryan"];

  # -- Bootloader & Kernel --
  boot.loader = {
    systemd-boot.enable = false;
    efi.canTouchEfiVariables = true;
    limine = {
      enable = true;
      efiSupport = true;
      secureBoot.enable = true;
      extraConfig = ''
        :Password protected entry
        COMMENT=Requires admin password to edit or boot
        PASSWORD=0013067
        '';
    };
  };
  boot.kernelModules = [
    "nvidia"
    "nvidia_modeset"
    "nvidia_uvm"
    "nvidia_drm"
  ];
  boot.kernelParams = [
    "nvme_core.default_ps_max_latency_us=0"
    "pcie_aspm=off"
    "nvidia-drm.modeset=1"
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  # -- Artificial Stupidity --
  services.ollama = {
    enable = true;
    package = pkgs.ollama-cuda;
  };

  # -- Security --
  security.protectKernelImage = true;
  security.unprivilegedUsernsClone = false;
  security.apparmor.enable = true;
  security.apparmor.killUnconfinedConfinables = true;
  
  boot.kernel.sysctl = {
  	"kernel.kptr_restrict" = 2;
 	"kernel.dmesg_restrict" = 1;
    "net.core.bpf_jit_harden" = 2;
 	"fs.protected_hardlinks" = 1;
 	"fs.protected_symlinks" = 1;
 	"net.ipv4.conf.all.rp_filter" = 1;
 	"net.ipv4.conf.default.rp_filter" = 1;
 	"net.ipv4.tcp_syncookies" = 1;
  };

  networking.firewall = {
  	enable = true;
  	allowPing = false;
  	logRefusedConnections = false;
  };

  # -- Swapfile & ZRam --
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 4 * 1024;
    }
  ];

  zramSwap = {
    enable = true;
    priority = 50;
    memoryPercent = 15;
  };

  # -- Graphics & NVIDIA Drivers --
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
    modesetting.enable = true;
    powerManagement.enable = false;
    open = false;
    prime = {
      sync.enable = true;
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  hardware.graphics.extraPackages = with pkgs; [
  	nvidia-vaapi-driver
  ];

  # -- Desktop Environments & Display --
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    displayManager.lightdm.enable = false;
    desktopManager.cinnamon.enable = true;
  };

  services.displayManager.gdm.enable = true;
  programs.hyprland.enable = true;
  services.displayManager.sddm.wayland.enable = false;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

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
    shell = pkgs.fish;
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "audio"
      "input"
    ];
    packages = with pkgs; [ ];
  };

  # -- System Packages --
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
  ];

  # -- Programs & Gaming --
  services.fwupd.enable = true;
  programs.zsh.enable = true;
  programs.fish.enable = true;
  programs.firefox.enable = true;
  services.flatpak.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  # -- Nix Settings & State --
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.nvidia.acceptLicense = true;
  system.stateVersion = "26.05";
}
