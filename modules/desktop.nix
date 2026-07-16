{ ... }:

{
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    displayManager.lightdm.enable = false;
    desktopManager.cinnamon.enable = true;
  };

  services.displayManager.gdm.enable = true;
  services.displayManager.sddm.wayland.enable = false;
  programs.hyprland.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
