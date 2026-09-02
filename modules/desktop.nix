{ pkgs, ... }:

{
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    desktopManager.cinnamon.enable = true;
  };

  services.displayManager.sddm = {
      enable = true;
      theme = "sugar-dark";
      extraPackages = with pkgs; [ 
        sddm-sugar-dark
      ];
      wayland.enable = true;
  };

  programs.hyprland.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
