{ config, pkgs, ... }:
let
  aliases = {
    upd  = "sudo nix flake update";
    hm   = "home-manager switch --flake .#ryan";
    dot  = "cd ~/.dotfiles";
    gm   = "git commit -m";
    rs   = "sudo nixos-rebuild switch --flake .#craptop";
    ls   = "lsd";
    l    = "ls -l";
    la   = "ls -a";
    lla  = "ls -la";
    lt   = "ls --tree";
    src  = "source ~/.config/fish/config.fish";
    pls  = "sudo \$history[1]"; # Fixed: Added backslash to prevent Nix from crashing on '$history'
    ex   = "exit";
    cl   = "clear";
    ga   = "git add .";
    gp   = "git push";
    gc   = "git commit -m .";
    hypr = "cd ~/.config/hypr";
    conf = "cd ~/.config";
    tung = "echo 'tung tung tung sahur'";
  };
in
{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      add_newline = false;
      character = {
        success_symbol = "[➜](bold green) ";
        error_symbol = "[➜](bold red) ";
      };
        
      git_branch = {
        symbol = "🌿 ";
        style = "bold purple";
      };
    };
  };

  programs.fish = {
    enable = true;
    shellAliases = aliases;

    plugins = [
      {
        name = "enhancd";
        src = pkgs.fetchFromGitHub {
          owner = "b4b4r07";
          repo = "enhancd";
          rev = "master";
          sha256 = "sha256-pKQbwiqE0KdmRDbHQcW18WfxyJSsKfymWt/TboY2iic="; # Updated with the live hash
        };
      }
      {
        name = "done";
        src = pkgs.fetchFromGitHub {
          owner = "franciscolourenco";
          repo = "done";
          rev = "1.19.3"; 
          sha256 = "sha256-DMIRKRAVOn7YEnuAtz4hIxrU93ULxNoQhW6juxCoh4o=";
        };
      }
    ];
    
    interactiveShellInit = ''
      set fish_greeting
      set -g fish_color_command a855f7
      set -g fish_color_param e0d4ff
      set -g fish_color_autosuggestion 8866aa
      
      # Fixed: Using the system 'fzf' dynamically from your $PATH instead of the Nix store
      if type -q fzf
          fzf --fish | source
      end
    '';
  };
  
  home.packages = [ pkgs.lsd ];
}
