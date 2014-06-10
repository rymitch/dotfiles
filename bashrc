# Customize the environment for Cygwin. This must execute
# before any other commands that modify PATH.

if [ "$OSTYPE" = "cygwin" ]; then
  source ${HOME}/.bash_cygwin
fi

# PATH environment variable

if [ -d "/usr/local/bin" ]; then
  PATH=/usr/local/bin:${PATH}
fi

if [ -d /opt/local/sbin ]; then
  PATH=/opt/local/sbin:${PATH}
fi
if [ -d /opt/local/bin ]; then
  PATH=/opt/local/bin:${PATH}
fi

if [ -d "${HOME}/bin" ]; then
  PATH=${HOME}/bin:${PATH}
fi
if [ "$OSTYPE" = "darwin11" ] && [ -d "${HOME}/bin/osx" ]; then
  PATH=${HOME}/bin/osx:${PATH}
fi
if [ "$OSTYPE" = "cygwin" ] && [ -d "${HOME}/bin/win" ]; then
  PATH=${HOME}/bin/win:${PATH}
fi
if [ -d /cygdrive/c/Program\ Files/Oracle/VirtualBox ]; then
  PATH=/cygdrive/c/Program\ Files/Oracle/VirtualBox:${PATH}
fi
if [ -d /cygdrive/c/HashiCorp/Vagrant/bin ]; then
  PATH=/cygdrive/c/HashiCorp/Vagrant/bin:${PATH}
fi
if [ -d /cygdrive/c/Program\ Files/nodejs ]; then
  PATH=/cygdrive/c/Program\ Files/nodejs:${PATH}
fi

# MANPATH environment variable

if [ -d "/usr/local/man" ]; then
  export MANPATH=/usr/local/man:${MANPATH}
fi
if [ -d "/opt/local/man" ]; then
  export MANPATH=/opt/local/man:${MANPATH}
fi
if [ -d "${HOME}/man" ]; then
  export MANPATH=${HOME}/man:${MANPATH}
fi

# INFOPATH environment variable

if [ -d "/usr/local/info" ]; then
  export INFOPATH=/usr/local/info:${INFOPATH}
fi
if [ -d "/opt/local/info" ]; then
  export INFOPATH=/opt/local/info:${INFOPATH}
fi
if [ -d "${HOME}/info" ]; then
  export INFOPATH=${HOME}/info:${INFOPATH}
fi

# PYTHONPATH environment variable

if [ -d "/opt/local/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/site-packages" ]; then
  export PYTHONPATH=/opt/local/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/site-packages:${PYTHONPATH}
fi

# Git tab completion from bash.

[[ -s "$HOME/bin/git-completion.bash" ]] && source "$HOME/bin/git-completion.bash"

_git_dm()
{
  _git_branch
}

# Ruby RVM

if [ -d "${HOME}/.rvm" ]; then
  PATH=$PATH:$HOME/.rvm/bin
fi
if [ -d "${HOME}/.gem/ruby/1.8/bin" ]; then
  PATH=$PATH:${HOME}/.gem/ruby/1.8/bin
fi
if [ -d "${HOME}/.gem/ruby/1.9.1/bin" ]; then
  PATH=$PATH:${HOME}/.gem/ruby/1.9.1/bin
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# User has read/write, group has read, other has none.

umask 0027

# CUDA

if [ -d /usr/local/cuda/lib ]; then
  export LD_LIBRARY_PATH=/usr/local/cuda/lib:$LD_LIBRARY_PATH
fi
if [ -d /usr/local/cuda/lib64 ]; then
  export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
fi
if [ -d /usr/local/cuda/bin ]; then
  PATH=/usr/local/cuda/bin:$PATH
fi
if [ -d /usr/lib/nvidia-current ]; then
  export LPATH=/usr/lib/nvidia-current:$LPATH
  export LIBRARY_PATH=/usr/lib/nvidia-current:$LIBRARY_PATH
  export LD_LIBRARY_PATH=/usr/lib/nvidia-current:$LD_LIBRARY_PATH
fi

# If not running interactively, don't do anything else.

[ -z "$PS1" ] && return

# Start the ssh-agent. From http://mah.everybody.org/docs/ssh.

SSH_ENV="$HOME/.ssh/environment"

function start_agent {
   /usr/bin/ssh-agent -t 2h | sed 's/^echo/#echo/' > "${SSH_ENV}"
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

# Don't put duplicate lines in the history.
# Ignore common commands.

export HISTCONTROL="ignoreboth"
export HISTIGNORE="[   ]*:&:bg:fg:exit"

# Set the default editor.

export EDITOR=vim

# Set the default browser.

if [ -n "$USERPROFILE" ]; then
  export BROWSER=`cygpath "$USERPROFILE"`/AppData/Local/Google/Chrome/Application/chrome.exe
fi

# Append to the history file (don't overwrite it).

shopt -s histappend

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

# Make less more friendly for non-text input files.

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# If this shell is interactive, turn on programmable completion
# enhancements. Any completions you add in ~/.bash_completion
# are sourced last.

case $- in
  *i*) [[ -f /etc/bash_completion ]] && . /etc/bash_completion ;;
esac

# Prompts.

export PS1="\[\e[0;32m\]\h:\w\$ \[\e[m\]"
export PS2="\[\e[1;31m\]\h:\w> \[\e[m\]"

# Whenever displaying the prompt, write the previous line to disk.

export PROMPT_COMMAND="history -a"

# Load aliases.

if [ -f "${HOME}/.bash_aliases" ]; then
  source "${HOME}/.bash_aliases"
fi

# Load any existing private configuration.

if [ -f "${HOME}/.dotlocal/bash_private" ]; then
  source "${HOME}/.dotlocal/bash_private"
fi
