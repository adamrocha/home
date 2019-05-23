#!/bin/bash
export TERM=xterm-color
export CLICOLOR=1
export GREP_OPTIONS='--color=auto'
# export LSCOLORS=Exfxcxdxbxegedabagacad
export LSCOLORS=gxfxcxdxbxegedabagacad # Dark lscolor scheme
# Don't put duplicate lines in your bash history
export HISTCONTROL=ignoredups
# increase history limit (100KB or 5K entries)
export HISTFILESIZE=100000
export HISTSIZE=5000

# Readline, the line editing library that bash uses, does not know
# that the terminal escape sequences do not take up space on the
# screen. The redisplay code assumes, unless told otherwise, that
# each character in the prompt is a `printable' character that
# takes up one character position on the screen. 

# You can use the bash prompt expansion facility (see the PROMPTING
# section in the manual page) to tell readline that sequences of
# characters in the prompt strings take up no screen space. 

# Use the \[ escape to begin a sequence of non-printing characters,
# and the \] escape to signal the end of such a sequence.
# Define some colors first:
RED='\[\e[1;31m\]'
BOLDYELLOW='\[\e[1;33m\]'
GREEN='\[\e[0;32m\]'
BLUE='\[\e[1;34m\]'
DARKBROWN='\[\e[1;33m\]'
DARKGRAY='\[\e[1;30m\]'
CUSTOMCOLORMIX='\[\e[1;30m\]'
DARKCUSTOMCOLORMIX='\[\e[1;32m\]'
LIGHTBLUE="\[\033[1;36m\]"
PURPLE='\[\e[1;35m\]' #git branch
# EG: GREEN="\[\e[0;32m\]" 
#PURPLE='\[\e[1;35m\]'
#BLUE='\[\e[1;34m\]'
NC='\[\e[0m\]' # No Color
#PS1="\[\033[1;34;40m[\033[1;31;40m\u@\h:\w\033[1;34;40m]\033[1;37;40m $\033[0;37;0m\] "
#PS1="${CUSTOMCOLORMIX}\\u@\h: \\W]\\$ ${NC}"

# PS1 (shell prompt)
# set variable identifying the chroot you work in (used in the prompt below)
#if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
#    debian_chroot=$(cat /etc/debian_chroot)
#fi

#function parse_git_dirty {
#  git diff --quiet HEAD &>/dev/null
#  [[ $? == 1 ]] && echo "⚡"
#}

#function parse_git_branch {
#  local branch=$(__git_ps1 "%s")
#  [[ $branch ]] && echo "[$branch$(parse_git_dirty)]"
#}

#PS1="${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\$(parse_git_branch)\[\033[00m\]\$"

PS1="${LIGHTBLUE}\\u ${BOLDYELLOW}[\\W] ${PURPLE}\$(parse_git_branch)${DARKCUSTOMCOLORMIX}$ ${NC}"
#PS1="${DARKCUSTOMCOLORMIX}\\u@\h:\\W]${PURPLE}\$(parse_git_branch)${DARKCUSTOMCOLORMIX}$ ${NC}"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function

list_detailed_more()
{
	ls -lah $1 | more
}

parse_git_branch() {
 git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
export -f parse_git_branch

parse_svn_branch() {
 parse_svn_url | sed -e 's#^'"$(parse_svn_repository_root)"'##g' | awk -F / '{print "(svn::"$1 "/" $2 ")"}'
}
export -f parse_svn_branch

parse_svn_url() {
 svn info 2>/dev/null | grep -e '^URL*' | sed -e 's#^URL: *\(.*\)#\1#g '
}
export -f parse_svn_url

parse_svn_repository_root() {
 svn info 2>/dev/null | grep -e '^Repository Root:*' | sed -e 's#^Repository Root: *\(.*\)#\1\/#g '
}
export -f parse_svn_repository_root

# Safe rm procedure
safe_rm()
{
    # Cycle through each argument for deletion
    for file in $*; do
        if [ -e $file ]; then

            # Target exists and can be moved to Trash safely
            if [ ! -e ~/.Trash/$file ]; then
                mv $file ~/.Trash

            # Target exists and conflicts with target in Trash
            elif [ -e ~/.Trash/$file ]; then

                # Increment target name until 
                # there is no longer a conflict
                i=1
                while [ -e ~/.Trash/$file.$i ];
                do
                    i=$(($i + 1))
                done

                # Move to the Trash with non-conflicting name
                mv $file ~/.Trash/$file.$i
            fi

        # Target doesn't exist, return error
        else
            echo "rm: $file: No such file or directory";
        fi
    done
}

function github() {
  #call from a local repo to open the repository on github in browser
  giturl=$(git config --get remote.origin.url)
  if [ "$giturl" == "" ]
    then
     echo "Not a git repository or no remote.origin.url set"
     exit 1;
  fi
  giturl=${giturl/git\@github\.com\:/https://github.com/}
  giturl=${giturl/\.git//}
  echo $giturl
  open $giturl
}


#bash git completion
if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi
