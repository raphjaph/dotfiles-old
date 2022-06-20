{ config, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      asciiquarium
      bat
      btop
      curl
      fd
      ffmpeg
      fzf
      git
      htop
#      hugo
      jq
      netcat
      pdfgrep
      pfetch
      pstree
      ripgrep
      silver-searcher
      socat
      sshfs
      tree
      tree
      neovim
      wget
    ];
    
    sessionVariables = {
      EDITOR                = "nvim";
      VISUAL                = "nvim";
      MYVIMRC               = "$HOME/.config/nvim/init.vim";
      VIMINIT               = "source $MYVIMRC";
    }; 
    sessionPath = [ "$HOME/bin" ];
  };
  
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "fd --type f --color=never --hidden";
    defaultOptions = [ "--height 75% --multi --reverse --bind ctrl-f:page-down,ctrl-b:page-up" ];
    fileWidgetCommand = "fd --type f --color=never --hidden";
    fileWidgetOptions = [ "--preview 'bat --color=always --line-range :500 {}'" ];
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
#    dotDir = ".config/zsh";
    initExtra = ''
      PROMPT=$'\n%F{green}%n@%m%f %B%F{cyan}%~%f%b\n> '
     
      # share history between windows/panes
      setopt inc_append_history
    '';
    shellAliases = {
      ls        = "ls -G";
      ll        = "ls -lGh";
      la        = "ls -laGh";
      vim       = "nvim";
      ffe       = "fzf_edit"; 
      fcd       = "fzf_change_directory";
      dotfiles  = "/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME";
      dot       = "dotfiles";
    };
    defaultKeymap = "viins";
  };

  programs.git = {
    enable = true;
    userName = "raphjaph";
    userEmail = "raphjaph@protonmail.com";
  };
  
  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;
}
