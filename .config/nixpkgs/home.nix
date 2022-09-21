{ config, pkgs, ... }:
let
  username = "raphael";
  home = "/Users/raphael";
in
{
  home = {
    username = username;
    homeDirectory = home;
    packages = with pkgs; [
      asciiquarium
      bat
      btop
      bitcoind
      fd
      ffmpeg
      fzf
      skim
      git
      gnupg
      go
      gopls
      helix
      htop
      jq
      neovim
      pdfgrep
      pfetch
      pstree
      python3
      qrencode
      reattach-to-user-namespace
      ripgrep
      rustup
      rust-analyzer
      silver-searcher
      socat
      sshfs
      tldr
      tmux
      tree
      wget
# broken:     hugo
# broken:     netcat
# broken:     python310Packages.howdoi
    ];
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
      PROMPT=$'\n%F{green}%m%f %B%F{cyan}%~%f%b\n> '

      # share history between windows/panes
      setopt inc_append_history
      
      # set some env vars
      EDITOR="hx"
      VISUAL="hx"
      MYVIMRC="$HOME/.config/nvim/init.vim"
      VIMINIT="source $MYVIMRC"
      TERM="alacritty"
    '';
    shellAliases = {
      b         = "bat --style=plain";
      bp        = "bat --style=plain --paging=always";
      c         = "clear";
      dot       = "dotfiles";
      dotfiles  = "/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME";
      dotls     = "dotfiles ls-tree -r --full-tree";
      ffd       = "cd $(fzf_directory)";
      ffe       = "fzf_edit";
      gs        = "git status";
      gc        = "git commit --verbose";
      gap       = "git add -p";
      gcb       = "git checkout -b";
      h         = "hx";
      hm        = "home-manager";
      la        = "ls -laGh";
      ll        = "ls -lGh";
      ls        = "ls -G";
      lv        = "nvim -c \"normal '0\" -c bd1";
      man       = "colorful_man";
      o         = "open .";
      p         = "python -q";
      qr        = "qrencode -t ansiutf8";
      s         = "source $HOME/.zshrc";
      sn        = "search_notes";
      update    = "home-manager switch && source $HOME/.zshrc";
      vim       = "nvim";
    };
    defaultKeymap = "viins";
  };

#  programs.fzf = {
#    enable = true;
#    enableZshIntegration = true;
#    defaultCommand = "fd --type f --color=never --hidden";
#    defaultOptions = [ "--height 75% --multi --reverse --bind ctrl-f:page-down,ctrl-b:page-up" ];
#    fileWidgetCommand = "fd --type f --color=never --hidden";
#    fileWidgetOptions = [ "--preview 'bat --color=always --line-range :500 {}'" ];
#  };

  programs.skim = {
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
    delta.enable = true;
    delta.options = ''
      
    '';
  };

  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;
}
