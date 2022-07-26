{ config, pkgs, ... }:
{
  home = {
    username = "raphael";
    homeDirectory = "/Users/raphael";
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
      go
      gopls
      htop
      jq
      neovim
# broken:     netcat
      pdfgrep
      pfetch
      pstree
      python3
      qrencode
      reattach-to-user-namespace
      ripgrep
      silver-searcher
      socat
      sshfs
      tldr
      tmux
      tree
      wget
#      hugo
#      python310Packages.howdoi
    ];
    
    sessionVariables = {
      EDITOR                = "nvim";
      VISUAL                = "nvim";
      MYVIMRC               = "$HOME/.config/nvim/init.vim";
      VIMINIT               = "source $MYVIMRC";
      TERM                  = "alacritty";
    }; 
    sessionPath = [ 
      "$HOME/bin"
      "/usr/local/bin"
      "/usr/local/sbin"
    ];
    stateVersion = "21.11";
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
      gs        = "git status";
      vim       = "nvim";
      lv        = "nvim -c \"normal '0\" -c bd1";
      ffe       = "fzf_edit"; 
      ffd       = "cd $(fzf_directory)";
      hm        = "home-manager";
      sn        = "search_notes";
      h         = "help"; 
      dotfiles  = "/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME";
      dot       = "dotfiles";
      dotls     = "dotfiles ls-tree -r --full-tree";
      qr        = "qrencode -t ansiutf8";
      man       = "colorful_man";
      s         = "source $HOME/.zshrc";
    };
    defaultKeymap = "viins";
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "fd --type f --color=never --hidden";
    defaultOptions = [ "--height 75% --multi --reverse --bind ctrl-f:page-down,ctrl-b:page-up" ];
    fileWidgetCommand = "fd --type f --color=never --hidden";
    fileWidgetOptions = [ "--preview 'bat --color=always --line-range :500 {}'" ];
  };
  
  programs.git = {
    enable = true;
    userName = "raphjaph";
    userEmail = "raphjaph@protonmail.com";
  };
  
  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;
}
