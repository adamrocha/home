
# Setting PATH for Python 3.4
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.4/bin:${PATH}"
export PATH

# Git branch in prompt.

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
# git branch 2>/dev/null | /usr/bin/grep '^*' | colrm 1 2)"
}

PS1_date="\[\033[38;5;237m\]\d\[$(tput sgr0)\]\[\033[38;5;15m\]"
PS1_time="\[$(tput sgr0)\]\[\033[38;5;236m\]\t\[$(tput sgr0)\]\[\033[38;5;15m\]"
PS1_wdir="\[$(tput sgr0)\]\[\033[38;5;24m\]\W"
PS1_gitbranch="\e[38;5;204m\]\$(parse_git_branch)"
PS1_gt="\[$(tput bold)\]\[$(tput sgr0)\]\[\e[38;5;214m\]>"
PS1_other="\[$(tput sgr0)\]\[$(tput sgr0)\]\[\e[38;5;15m\]"

export PS1="${PS1_date} ${PS1_time} ${PS1_wdir}${PS1_gitbranch}${PS1_gt}${PS1_other} \[$(tput sgr0)\]"

# BASH git completion
# run brew install git bash-completion

[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion || {
    # if not found in /usr/local/etc, try the brew --prefix location
    [ -f "$(brew --prefix)/etc/bash_completion.d/git-completion.bash" ] && \
        . $(brew --prefix)/etc/bash_completion.d/git-completion.bash
}
