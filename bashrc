# Does the command exist?

exists() { type -t "$1" > /dev/null 2>&1; }

# Add to the path, if the directory exists and it is
# not already in the path.

path-append() {
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    path-remove $1
    PATH="${PATH:+"$PATH:"}$1"
  fi
}
path-prepend() {
  path-remove $1
  PATH="$1:$PATH"
}
path-remove() {
  export PATH=`echo -n $PATH | awk -v RS=: -v ORS=: '$0 != "'$1'"' | sed 's/:$//'`;
}

# Don't put duplicate lines in the history. Ignore
# common commands.

export HISTCONTROL="ignoreboth"
export HISTIGNORE="[   ]*:&:bg:fg:exit"

# Append to the history file (don't overwrite it).

shopt -s histappend

# Whenever displaying the prompt, write the previous
# line to disk. Make sure to do this prior to sourcing
# ~/local/etc/bashrc.

export PROMPT_COMMAND="history -a"

# Prompts.

export PS1="\[\e[0;32m\]\h:\w\$ \[\e[m\]"
export PS2="\[\e[1;31m\]\h:\w> \[\e[m\]"

# Load the local bashrc.

if [ -f "$HOME/local/etc/bashrc" ]; then
  source "$HOME/local/etc/bashrc"
fi

# On cygwin, ignore some specific parts of the
# environment that don't translate well.

if [ "$OSTYPE" == "cygwin" ]; then
  export PATH=/usr/local/bin:/usr/bin
  unset VIM
fi

# Homebrew can be picky about the versions of utilities
# that it uses. Make sure that /usr/local/bin is first in
# the path. Pkgsrc should come next.

path-prepend /opt/pkg/bin
path-prepend /opt/pkg/sbin
path-prepend /usr/local/bin

# Update PATH.

path-append /usr/bin
[ "$OSTYPE" != "cygwin" ] && path-append /bin
path-append /usr/sbin
[ "$OSTYPE" != "cygwin" ] && path-append /sbin
path-append /opt/X11/bin
path-append $HOME/local/bin
path-append $HOME/bin
path-append /cygdrive/c/Windows/system32
path-append /cygdrive/c/Windows
path-append /cygdrive/c/Windows/System32/Wbem
path-append /cygdrive/c/Windows/System32/WindowsPowerShell/v1.0

# Load aliases.

if [ -f "$HOME/.bash_aliases" ]; then
  source "$HOME/.bash_aliases"
fi

# Load .bash_local, if it exists.

if [ -f "$HOME/.bash_local" ]; then
  source "$HOME/.bash_local"
fi

# Tab completion.

if exists brew && [[ -f "`brew --prefix`/etc/bash_completion.d/git-completion.bash" ]]; then
. "`brew --prefix`/etc/bash_completion.d/git-completion.bash"
fi
if exists brew && [[ -f "`brew --prefix`/etc/bash_completion.d/hg-completion.bash" ]]; then
. "`brew --prefix`/etc/bash_completion.d/hg-completion.bash"
fi
if exists brew && [[ -f "`brew --prefix`/etc/bash_completion.d/docker" ]]; then
. "`brew --prefix`/etc/bash_completion.d/docker"
fi
if exists brew && [[ -f "`brew --prefix`/etc/bash_completion.d/npm" ]]; then
. "`brew --prefix`/etc/bash_completion.d/npm"
fi

# AWS bash tab completion.

command -v aws_completer >/dev/null && complete -C aws_completer aws

_git_dm()
{
  _git_branch
}

# User has read/write, group has read, other has none.

umask 0027

# If not running interactively, don't do anything else.

[ -z "$PS1" ] && return

# Start the ssh-agent. From http://mah.everybody.org/docs/ssh.

SSH_ENV="$HOME/.ssh/environment"

function start_agent {
   ssh-agent -t 2h | sed 's/^echo/#echo/' > "${SSH_ENV}"
   chmod 600 "${SSH_ENV}"
   . "${SSH_ENV}" > /dev/null
}

if [ -f "${SSH_ENV}" ]; then
   . "${SSH_ENV}" > /dev/null
   ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
       start_agent;
   }
else
   start_agent;
fi

# Set the default editor.

export EDITOR=vim

# Set the default browser.

if [ -n "$USERPROFILE" ]; then
  export BROWSER=`cygpath "$USERPROFILE"`/AppData/Local/Google/Chrome/Application/chrome.exe
fi

# When changing directory small typos can be ignored by bash.
# For example, cd /vr/lgo/apaache would find /var/log/apache.

shopt -s cdspell

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.

shopt -s checkwinsize

# Set vi mode.

set -o vi

# Don't use Ctrl+D to exit the interactive shell.

set -o ignoreeof

# Initialize pyenv.

if exists pyenv; then
  eval "$(pyenv init -)"
fi
if exists pyenv-virtualenv; then
  eval "$(pyenv virtualenv-init -)"
fi
export PYENV_VIRTUALENV_DISABLE_PROMPT=1

# Make less more friendly for non-text input files.

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# If this shell is interactive, turn on programmable completion
# enhancements. Any completions you add in ~/.bash_completion
# are sourced last.

# case $- in
#   *i*) [[ -f /etc/bash_completion ]] && . /etc/bash_completion ;;
# esac
