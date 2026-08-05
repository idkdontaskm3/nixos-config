{ inputs, ...}:
{

  imports = [
      inputs.noctalia.homeModules.default
  ];

  programs.noctalia = {
    enable =  true;

    settings = {
      theme = {
        mode = "dark";
        source = "builtin";
        builtin = "Catppuccin";
      };
      
      opacity = 0.85;

      wallpaper = {
        enabled = false;
      };
    };
  };
}
