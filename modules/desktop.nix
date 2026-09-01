{ ... }:

{
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    desktopManager.cinnamon.enable = true;
  };

  programs.niri.enable = true;
  programs.hyprland.enable = true;
  services.displayManager.gdm.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
