if status is-interactive
    set fish_greeting ""
    pyenv init - | source
    #pyenv virtualenv-init - | source
    #pyenv virtualenvwrapper_lazy
end

set -gx PYENV_VIRTUALENV_DISABLE_PROMPT 1
