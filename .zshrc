#PROMPT='%F{208}%n%f@%m %F{226}%~%f > '
PROMPT=$'\n%F{cyan}%~\n%B%F{green}>%f%b '

# Homebrew
export PATH=$PATH:/usr/local/bin

# V Lang
export PATH=$PATH:$HOME/v

# Golang
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# Yubikey ssh-agent
export SSH_AUTH_SOCK="$(brew --prefix)/var/run/yubikey-agent.sock"

# vim
export EDITOR="vim"
export VISUAL="vim"
export VIMINIT="source ~/.config/vim/vimrc"

# Vi mode
bindkey -v
export KEYTIMEOUT=1

# syntax highlighting
source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# auto suggestions
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# history substring search/match
source ~/.config/zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# completions
fpath=(~/.config/zsh/zsh-completions/src $fpath)
#rm -f ~/.zcompdump; compinit

# Aliases
alias ls='ls -G'
alias ll='ls -lG'
alias la='ls -laG'

alias cat='bat -pp'

alias gs='git status'
alias ga='git add'
alias gc='git commit -m'

alias tm='tmux'
alias tml='tmux list-sessions'
alias tma='tmux attach -t'
alias tmk='tmux kill-session -t'

alias d='docker'
alias dc='docker-compose'

alias g='glow'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias f='fzf'

# USAGE: dotfiles add ...; dotfiles commit -m "..."; dotfiles push;
# Source: https://www.ackama.com/what-we-think/the-best-way-to-store-your-dotfiles-a-bare-git-repository-explained/
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias dot='dotfiles'
