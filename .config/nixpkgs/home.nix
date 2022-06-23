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
      gnupg
      htop
      jq
      neovim
      netcat
      pdfgrep
      pfetch
      pstree
      qrencode
      ripgrep
      silver-searcher
      socat
      sshfs
      tree
      tmux
      reattach-to-user-namespace
      wget
#      hugo
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
      lvim      = "nvim -c \"normal '0\" -c bd1";
      ffe       = "fzf_edit"; 
      fcd       = "fzf_change_directory";
      dotfiles  = "/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME";
      dot       = "dotfiles";
      qr        = "qrencode -t ansiutf8";
      man       = "colorful_man";
      s         = "source $HOME/.zshrc";
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
