{ pkgs, ... }:

{
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    desktopManager.cinnamon.enable = true;
  };

  services.displayManager.sddm = {
      enable = true;
      theme = "sddm-astronaut-theme";
      extraPackages = with pkgs; [ 
        kdePackages.qtmultimedia
        (sddm-astronaut.override {
           embeddedTheme = "purple_leaves";
        })
      ];
      wayland.enable = true;
  };

  programs.hyprland.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
