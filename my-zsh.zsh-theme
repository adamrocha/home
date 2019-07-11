# My ZSH theme
# Author: Adam Rocha
# Last modifed: 2019-7-10

local ret_status="%(?:%{$fg_bold[white]%}[%*] :%{$fg_bold[red]%}[%*] )"
PROMPT='${ret_status}%{$fg[yellow]%}%n%{$fg[magenta]%}@%{$fg[cyan]%}%M%{$reset_color%}:%{$fg[white]%}%c%{$reset_color%} $(git_prompt_info)%(!.#.$) '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
