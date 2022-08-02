#!/bin/sh
export BROWSER="firefox"
export READER="zathura"
export TERMINAL="alacritty"
# export LIBGL_ALWAYS_SOFTWARE=1 # Needed for alacritty on virtualbox
export I3CONF=$HOME/.config/i3/config
export COMPRC=$HOME/.config/compton.conf
export ZSHRC=$HOME/.zshrc
export ZDOTDIR=$HOME/.config/zsh
export XINITRC=$HOME/.xinitrc
export XRESOURCES=$HOME/.Xresources
export BIB="$HOME/latex/bibliography.bib"

export PATH="$HOME/.local/bin:$(du "$HOME/.local/bin" | cut -f2 | tr '\n' ':' | sed 's/:*$//'):$PATH:/usr/local/go/bin"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export WORKON_HOME=~/.ve
export PROJECT_HOME=~/projects
eval "$(pyenv init --path)"
. "$HOME/.cargo/env"

if command -v nvim > /dev/null 2>&1; then
	export EDITOR="nvim"
	export MANPAGER="nvim +Man!"
	export VIMRC=~/.config/nvim/init.vim
	export VIMCONF=~/.config/nvim
elif command -v vim > /dev/null 2>&1; then
	export EDITOR="vim"
	export VIMRC=~/.vimrc
	export VIMCONF=~/.vim
else
	export EDITOR="vi"
	export VIMRC=~/.vimrc
	export VIMCONF=~/.vim
fi
