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

# Don't put duplicate lines in the history.
export HISTCONTROL="ignoreboth"

# Ignore common commands from the history.
export HISTIGNORE="[   ]*:&:bg:fg:ls:dir:exit:cls:git l:git st"

# Add a timestamp to history.
export HISTTIMEFORMAT='%F %T '

# Enable unlimited history.
export HISTFILESIZE=-1
export HISTSIZE=-1

# Append to the history file (don't overwrite it).
shopt -s histappend

# Attempt to save multi-line commands.
shopt -s cmdhist

# After each command, append the history and reload.
# This allows multiple shells to cooperate nicely.
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$"\n"}history -a; history -c; history -r"

# Silence the annoying and useless "Display all
# 9,982 possiblities" bash prompt on an empty line.
shopt -s no_empty_cmd_completion

# Prompts.

export PS1="\[\e[0;32m\]\h:\w\$ \[\e[m\]"
export PS2="\[\e[1;31m\]\h:\w> \[\e[m\]"

# On Microsoft platforms, ignore some specific parts
# of the environment that don't translate well.

if [ "$OSTYPE" == "cygwin" ]; then
  export PATH=/usr/local/bin:/usr/bin
  unset VIM
fi

# Update PATH.

path-prepend /usr/local/opt/python/libexec/bin
path-prepend $HOME/.npm-packages/bin
path-prepend $HOME/.local/bin
path-prepend /usr/local/bin
path-prepend /opt/wine-stable/bin
path-append /usr/bin
[ "$OSTYPE" != "cygwin" ] && path-append /bin
path-append /usr/sbin
[ "$OSTYPE" != "cygwin" ] && path-append /sbin
path-append /opt/X11/bin
path-append $HOME/.dotfiles/bin
path-append $HOME/bin

# Add Windows paths, in both WSL and Cygwin formats.

path-append /cygdrive/c/Program\ Files/dotnet
path-append /mnt/c/Program\ Files/dotnet

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
  elif [ "$(lsb_release -si)" == "Debian" ]; then
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

# Load fzf.

if [ -f ~/.fzf.bash ]; then
  . ~/.fzf.bash
fi

# Enable tab completion.

if [ -f /usr/share/bash-completion/bash_completion ]; then
  . /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

# Enable the nix package manager.

if [ -f ${HOME}/.nix-profile/etc/profile.d/nix.sh ]; then
  . ${HOME}/.nix-profile/etc/profile.d/nix.sh
fi

# Intialize goenv.

if [ -d ${HOME}/.goenv ] ; then
  export GOENV_ROOT="$HOME/.goenv"
  export PATH="$GOENV_ROOT/bin:$PATH"
fi
if exists goenv; then
  eval "$(goenv init -)"
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

# Initialize rust.

if [ -d ${HOME}/.cargo/env ] ; then
  source "${HOME}/.cargo/env"
fi

# Make less more friendly for non-text input files.

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Silence accessibility bus warnings in Linux.

export NO_AT_BRIDGE=1

# Turn off .NET telemetry.

export DOTNET_CLI_TELEMETRY_OPTOUT=1
