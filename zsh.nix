{ config, pkgs, ... }:
let
  aliases = {
    upd = "sudo nix flake update";
    hm = "home-manager switch --flake .#ryan";
    dot = "cd ~/.dotfiles";
    gm = "git commit -m";
    rs = "sudo nixos-rebuild switch --flake .#craptop";
    ".." = "cd ..";
    "..." = "cd ../..";
    ls = "lsd";
    l = "ls -l";
    la = "ls -a";
    lla = "ls -la";
    lt = "ls --tree";
    src = "source ~/.zshrc";
    pls = "sh -c 'sudo !!'";
    ex = "exit";
    cl = "clear";
    ga = "git add .";
    gp = "git push";
    gc = "git commit -m .";
    hypr = "cd ~/.config/hypr";
    conf = "cd ~/.config";
    tung = "echo 'tung tung tung sahur'";
  };
in
{
  programs.zsh = {
    enable = true;
    shellAliases = aliases;

    history = {
      path = "${config.home.homeDirectory}/.zsh_history";
      size = 500;
      save = 500;
      append = true;
    };

    oh-my-zsh = {
      enable = true;
      theme = "ys";
      plugins = [
        "git"
      ];
    };

    plugins = [
      {
        name = "zsh-autosuggestions";
        src = pkgs.zsh-autosuggestions;
        file = "share/zsh-autosuggestions/zsh-autosuggestions.zsh";
      }
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.zsh-syntax-highlighting;
        file = "share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh";
      }
    ];

    initContent = ''
      source <(${pkgs.fzf}/bin/fzf --zsh)
    '';
  };

  home.packages = [ pkgs.lsd ];
}
