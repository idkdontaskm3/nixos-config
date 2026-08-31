{ ... }:

{
  networking.hostName = "craptop";
  networking.networkmanager = {
      enable = true;
      dns = "systemd-resolved";
  };
  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";

  nix.settings.substituters = [
    "https://cache.nixos.org"
    "https://nyx-cache.chaotic.cx"
  ];

  nix.settings.trusted-public-keys = [ 
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    "nyx-cache.chaotic.cx:dJxTrgMC3V3cFfyIiBQDQorG6k1LsqurH/srpMSq7qk="
  ];
}
