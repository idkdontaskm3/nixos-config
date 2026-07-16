{ config, pkgs, ... }:

{
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
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
}
