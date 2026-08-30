{ config, pkgs, ... }:
let
  aliases = {
    cl   = "clear";
    conf = "cd ~/.config";
    dot  = "cd ~/.dotfiles";
    ex   = "exit";
    fih  = "watch -n 0 mpv /home/ryan/Videos/fih/fih.mp4";
    ga   = "git add .";
    gc   = "git commit -m .";
    gf   = "ga && gc && gp";
    gm   = "git commit -m";
    gp   = "git push";
    hk   = "gamemoderun steam-run env PROTON_ENABLE_NVAPI=1 ./home/ryan/Torrents/hk/data/noarch/game/'Hollow Knight'";
    hm   = "home-manager switch --flake .#ryan";
    hypr = "cd ~/.config/hypr";
    l    = "ls -l";
    la   = "ls -a";
    lla  = "ls -la";
    ls   = "lsd";
    lt   = "ls --tree";
    pls  = "sudo \$history[1]"; # Fixed: Added backslash to prevent Nix from crashing on '$history'
    rs   = "sudo nixos-rebuild switch --flake .#craptop";
    src  = "source ~/.config/fish/config.fish";
    tung = "echo 'tung tung tung sahur'";
    upd  = "nix flake update";
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
          sha256 = "sha256-pKQbwiqE0KdmRDbHQcW18WfxyJSsKfymWt/TboY2iic=";
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
