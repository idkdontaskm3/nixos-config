{ ... }:

{
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    desktopManager.cinnamon.enable = true;
  };

  services.displayManager.sddm = {
      enable = true;
      theme = "elarun";
  };

  programs.hyprland.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
