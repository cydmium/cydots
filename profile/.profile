#!/bin/sh
if command -v nvim > /dev/null 2>&1; then
	export EDITOR="nvim"
	export MANPAGER="nvim -Man!"
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
