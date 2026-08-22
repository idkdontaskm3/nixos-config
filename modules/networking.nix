{ ... }:

{
  networking.hostName = "craptop";
  networking.networkmanager = {
      enable = true;
      dns = "systemd-resolved";
  };
  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";
}
