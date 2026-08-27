{ ... }:

{
  programs.zsh.enable = true;
  programs.fish.enable = true;
  programs.firefox.enable = true;
  programs.firejail.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
}
