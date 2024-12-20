# Correction Prompt
setopt correct
autoload -U colors && colors
export SPROMPT="Correct $fg[red]%R$reset_color to $fg[green]%r$reset_color? (Yes, No, Abort, Edit) "

unsetopt beep nomatch
HISTFILE=~/.zsh_history
