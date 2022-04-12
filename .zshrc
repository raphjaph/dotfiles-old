#PROMPT='%F{208}%n%f@%m %F{226}%~%f > '
PROMPT=$'\n%F{green}%n@%m%f %B%F{cyan}%~f%b\n> '

# share history between windows/panes
setopt inc_append_history

# Golang
export PATH=/usr/local/go/bin:$PATH

# vim
export EDITOR="nvim"
export VISUAL="nvim"
export VIMINIT="source ~/.config/nvim/init.vim"

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
source ~/.zsh_aliases
