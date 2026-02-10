{ config, pkgs, ... }:
let
  aliases = {
    ll = "ls -l";
    upd = "nix flake update";
    hm = "home-manager switch --flake .#ryan";
    cl = "clear";
    ex = "exit";
    dot = "cd ~/.dotfiles";
    src = "source /home/ryan/.bashrc";
    ".." = "cd ..";
    "..." = "cd ../..";
  };
in
{
  programs.bash = {
    enable = true;
    shellAliases = aliases;
  };
}
