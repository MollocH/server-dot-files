#!/usr/bin/zsh

cd $HOME/.server-dotfiles
git pull

source "$HOME/.zinit/bin/zinit.zsh"
cd ${HOME}

asdf update
asdf plugin update --all
zinit update --all
vim "+:PlugUpdate" "+:qall"
${HOME}/.tmux/plugins/tpm/bin/update_plugins all
tldr --update
