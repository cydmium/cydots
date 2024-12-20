function fish_prompt --description 'Write out the prompt'
    set -l last_status $status
    set -l pyenv_version (pyenv version-name | string split ':')[1]
    
    set status_color (set_color normal)
    if test $last_status -ne 0
        set status_color (set_color $fish_color_error)
    end
    echo ''
    string join '' -- (set_color blue) (prompt_pwd --full-length-dirs 2) (set_color 8D95A0) ' (' $pyenv_version ')'
    string join '' -- $status_color '>> ' (set_color normal)
end

function fish_right_prompt --description 'Write out the right prompt'
    set -g __fish_git_prompt_show_informative_status true
    set -g __fish_git_prompt_showuntrackedfiles true

    set -g __fish_git_prompt_color_branch EE8B4E
    set -g __fish_git_prompt_showupstream "informative"
    set -g __fish_git_prompt_char_upstream_ahead " ↑"
    set -g __fish_git_prompt_char_upstream_behind " ↓"
    set -g __fish_git_prompt_char_upstream_prefix ""

    set -g __fish_git_prompt_char_stagedstate " ●"
    set -g __fish_git_prompt_char_dirtystate " +"
    set -g __fish_git_prompt_char_untrackedfiles " …"
    set -g __fish_git_prompt_char_conflictedstate " ✖"
    set -g __fish_git_prompt_char_cleanstate " ✔"

    set -g __fish_git_prompt_color_dirtystate blue
    set -g __fish_git_prompt_color_stagedstate yellow
    set -g __fish_git_prompt_color_untrackedfiles blue
    set -g __fish_git_prompt_color_invalidstate red
    set -g __fish_git_prompt_color_cleanstate green
    echo (fish_vcs_prompt)
end
