
echo ".dotfiles" >> .gitignore
git clone --bare https://github.com/raphjaph/dotfiles.git $HOME/.dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
dotfiles config --local status.showUntrackedFiles no
dotfiles checkout
dotfiles submodule init
dotfiles submodule update
