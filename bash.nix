{ config, pkgs, ... }:
let
  aliases = {
    ll = "ls -l";
    upd = "sudo nix flake update";
    hm = "home-manager switch --flake .#ryan";
    cl = "clear";
    ex = "exit";
    pls = "sudo !!";
    dot = "cd ~/.dotfiles";
    src = "source /home/ryan/.bashrc";
    gm = "git commit -m";
    ga = "git add .";
    gp = "git push -u origin main";
    rs = "sudo nixos-rebuild switch --flake .#craptop";
    terarria = "NIXPKGS_ALLOW_UNFREE=1 FNA3D_FORCE_DRIVER=OpenGL __GL_THREADED_OPTIMIZATIONS=1 steam-run ~/GOG\\ Games/Terraria/game/Terraria";
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
