# Cydots

## Installation
To install, you will need `git` and GNU `stow` installed.
Clone this repository into your home directory:
``` bash
cd
git clone git@github.com:cydmium/cydots.git # Or if you don't have ssh keys 'git clone https://github.com/cydmium/cydots'
cd cydots
```
Use `stow` to install all of the config files
``` bash
stow */
```
or only some of the config files
``` bash
stow nvim
```

## Package Requirements
The neovim config relies on the 0.5 or nightly release, so ensure your neovim version (`nvim --version`) is greater than 0.5.
