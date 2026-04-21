{ config, pkgs, ... }:
let
  aliases = {
    ll = "ls -l";
    upd = "sudo nix flake update";
    hm = "home-manager switch --flake .#ryan";
    cl = "clear";
    ex = "exit";
    dot = "cd ~/.dotfiles";
    src = "source /home/ryan/.bashrc";
    gm = "git commit -m";
    ga = "git add .";
    gp = "git push -u origin main";
    rs = "sudo nixos-rebuild switch --flake .#craptop";
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
