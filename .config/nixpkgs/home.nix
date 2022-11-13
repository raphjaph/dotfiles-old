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
      htop
      just
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
      sumneko-lua-language-server
      sshfs
      tldr
      tmux
      tor
      tree
      wget
      zola
      zsh-completions
#      zsh-vi-mode
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
      export EDITOR=nvim
      export VISUAL=nvim
      
      # get nix working after macos update
      if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
      fi

      # better vi mode in zsh
      #source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
    '';
    shellAliases = {
      b         = "bat --style=plain";
      bp        = "bat --style=plain --paging=always";
      bcli      = "bitcoin-cli";
      bbcli     = "bitcoin-cli -rpccookiefile=/Users/raphael/bitcoin-rpc-cookie -rpcconnect=10.13.13.2";
      c         = "clear";
      dot       = "dotfiles";
      dotfiles  = "/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME";
      dotls     = "dotfiles ls-tree -r --full-tree main";
      ffd       = "cd $(fzf_directory)";
      ffe       = "fzf_edit";
      gs        = "git status";
      gc        = "git commit --verbose";
      gap       = "git add -p";
      gcb       = "git checkout -b";
      hm        = "home-manager";
      ls        = "ls -G --color";
      la        = "ls -laGh --color";
      ll        = "ls -lGh --color";
      lv        = "nvim -c \"normal '0\" -c bd1";
      man       = "colorful_man";
      o         = "open .";
      p         = "python -q";
      qr        = "qrencode -t ansiutf8";
      s         = "source $HOME/.zshrc";
      sn        = "search_notes";
      update    = "home-manager switch && source $HOME/.zshrc";
      vim       = "nvim";
      vimrc     = "cd ~/.config/nvim && nvim init.vim";
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
  };

  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;
}
