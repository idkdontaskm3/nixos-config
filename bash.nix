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
    gm = "git commit -m";
    ga = "git add .";
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
