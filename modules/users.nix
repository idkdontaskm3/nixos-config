{ pkgs, ... }:

{
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
}
