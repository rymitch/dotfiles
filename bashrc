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
# line to disk.

export PROMPT_COMMAND="history -a"

# Prompts.

export PS1="\[\e[0;32m\]\h:\w\$ \[\e[m\]"
export PS2="\[\e[1;31m\]\h:\w> \[\e[m\]"

# On cygwin, ignore some specific parts of the
# environment that don't translate well.

if [ "$OSTYPE" == "cygwin" ]; then
  export PATH=/usr/local/bin:/usr/bin
  unset VIM
fi

# Update PATH.

path-prepend /usr/local/bin
path-append /usr/bin
[ "$OSTYPE" != "cygwin" ] && path-append /bin
path-append /usr/sbin
[ "$OSTYPE" != "cygwin" ] && path-append /sbin
path-append /opt/X11/bin
path-append $HOME/.dotfiles/bin
path-append $HOME/bin

# Add Windows paths, in both WSL and Cygwin formats.

path-append /cygdrive/c/Windows/system32
path-append /mnt/c/Windows/system32

path-append /cygdrive/c/Windows
path-append /mnt/c/Windows

path-append /cygdrive/c/Windows/System32/Wbem
path-append /mnt/c/Windows/System32/Wbem

path-append /cygdrive/c/Windows/System32/WindowsPowerShell/v1.0
path-append /mnt/c/Windows/System32/WindowsPowerShell/v1.0

# Color scheme for ls.

if [[ -e $HOME/.dircolors ]]; then
  eval "$(dircolors -b ~/.dircolors)"
fi

# Load z.

if [[ -e $HOME/.dotfiles/z/z.sh ]]; then
  _Z_NO_RESOLVE_SYMLINKS=1
  . "$HOME/.dotfiles/z/z.sh"
  alias zp='pushd . && z'
fi

# Load aliases.

if [ -f "$HOME/.bash_aliases" ]; then
  source "$HOME/.bash_aliases"
fi

# Load .bash_local, if it exists.

if [ -f "$HOME/.bash_local" ]; then
  source "$HOME/.bash_local"
fi

# User has read/write, group has read, other has none.

umask 0027

# If not running interactively, don't do anything else.

[ -z "$PS1" ] && return

# Start the ssh keychain.

if exists keychain; then
  if [ "$OSTYPE" == "cygwin" ]; then
    keychain -q ~/.ssh/id_rsa
    source ~/.keychain/*-sh
  elif grep -q Microsoft /proc/version; then
    keychain -q ~/.ssh/id_rsa
    source ~/.keychain/*-sh
  fi
fi

# Set the default editor.

export EDITOR=vim

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

# Enable tab completion.

if [ -f /usr/share/bash-completion/bash_completion ]; then
  . /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

# Initialize pyenv.

if [ -d ${HOME}/anaconda3/bin ] ; then
    export PATH=${HOME}/anaconda3/bin:$PATH
elif [ -d ${HOME}/.pyenv ] ; then
  export PYENV_ROOT=${HOME}/.pyenv
  export PATH=${PYENV_ROOT}/bin:$PATH
  export PYENV_VIRTUALENV_DISABLE_PROMPT=1
fi
if exists pyenv; then
  eval "$(pyenv init -)"
fi
if exists pyenv-virtualenv; then
  eval "$(pyenv virtualenv-init -)"
fi

# Make less more friendly for non-text input files.

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Silence accessibility bus warnings in Linux.

export NO_AT_BRIDGE=1
