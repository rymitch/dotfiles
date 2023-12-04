autoload -Uz compinit
compinit

# Don't put duplicates into the path array.
typeset -U path

# Enable the Powerlevel10k instant prompt.
# Initialization code that may require console
# input (password prompts, [y/n] confirmations,
# etc.) must go above this block. Everything
# else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Turn off accessibility features, which silences the
# "Couldn't connect to accessibility bus" warning.
export NO_AT_BRIDGE=1

# .NET configuration
export DOTNET_CLI_TELEMETRY_OPTOUT=1
[[ -d ~/.dotnet/tools/ ]] && path+=(~/.dotnet/tools/)

# git configuration
if [[ -d /usr/share/doc/git/contrib/diff-highlight/ ]]; then
  path+=(/usr/share/doc/git/contrib/diff-highlight/)
fi
if [[ -d /usr/share/git-core/contrib/ ]]; then
  path+=(/usr/share/git-core/contrib/)
fi
if [[ -d /opt/homebrew/Cellar/git/2.43.0/share/git-core/contrib/diff-highlight ]]; then
  path+=(/opt/homebrew/Cellar/git/2.43.0/share/git-core/contrib/diff-highlight/)
fi

# Set the default editor and pager.
export EDITOR=vi
export PAGER=less

# Allow an application to open a URL. In WSL, first
# create a link to Windows Chrome. This avoids issues
# with spaces in the path.
# sudo ln -s "/mnt/c/Program Files (x86)/Google/Chrome/Application/chrome.exe" /usr/local/bin/chrome-win
if  [[ -x /usr/local/bin/chrome-win ]]; then
  export BROWSER=/usr/local/bin/chrome-win
fi

# Configure the ssh agent plugin.
zstyle :omz:plugins:ssh-agent agent-forwarding yes
zstyle :omz:plugins:ssh-agent lazy yes
zstyle :omz:plugins:ssh-agent lifetime 10h
zstyle :omz:plugins:ssh-agent quiet yes

# Load plugins.
source "${HOME}/.zgenom/zgenom.zsh"
zgenom autoupdate
if ! zgenom saved; then

  zgenom load agkozak/zsh-z
  zgenom load romkatv/powerlevel10k powerlevel10k
  zgenom load zsh-users/zsh-completions
  zgenom load zsh-users/zsh-syntax-highlighting
  zgenom ohmyzsh plugins/gitfast
  zgenom ohmyzsh plugins/ssh-agent
  zgenom ohmyzsh plugins/web-search

  # Load near the end.
  zgenom load unixorn/fzf-zsh-plugin

  zgenom save
fi

# Zsh configuration.
HISTFILE=~/.zhistory
HISTSIZE=1000000
SAVEHIST=1000000
setopt autocd
setopt correct
setopt histignorealldups
setopt histreduceblanks
setopt nomatch
setopt notify
setopt share_history
unsetopt beep
bindkey -v

# Aliases
alias bc='bc -l' # enable floating point math
alias clear='printf "\033c"'
alias cls='printf "\033c"'
alias df='df -h -x squashfs -x tmpfs -x devtmpfs'
alias dir='ls -AhlvLN --color=auto --group-directories-first'
alias du='du -h'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias ls='ls -hvN --color=auto --group-directories-first'
alias azurite-clean='rm -rf ~/.azurite && mkdir -p ~/.azurite && azurite --location ~/.azurite --debug ~/.azurite/debug.log'

# Use coreutils when available
if command -v gls &>/dev/null; then
  alias df="$(alias df | sed 's/^[^'\'']*'\''//;s/'\''$//;s/^df /gdf /')"
  alias dir="$(alias dir | sed 's/^[^'\'']*'\''//;s/'\''$//;s/^ls /gls /')"
  alias ls="$(alias ls | sed 's/^[^'\'']*'\''//;s/'\''$//;s/^ls /gls /')"
fi

# Apply maximum compression while maintaining zip compatibility.
# Usage: maxzip archive.zip <input files>
if command -v 7z &>/dev/null; then
  alias maxzip='7z a -tzip -mm=Deflate -mx=9 -mfb=258 -mpass=20'
fi

# Add the alias when the command is available.
command -v sc-im &>/dev/null && alias sc='sc-im'

# Customize Powerlevel10k. To customize, either
# run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Configure pyenv.
if command -v pyenv &>/dev/null; then
  export PYTHON_CONFIGURE_OPTS="--enable-shared"
  export PYENV_ROOT="$HOME/.pyenv"
  command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
fi

# Enable fuzzy completion.
if [[ -f ~/.fzf.zsh ]]; then
  # Home directory installation
  source ~/.fzf.zsh
else
  # Ubuntu installation
  if [[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]]; then
    source /usr/share/doc/fzf/examples/key-bindings.zsh
  fi
  if [[ -f /usr/share/doc/fzf/examples/completion.zsh ]]; then
    source /usr/share/doc/fzf/examples/completion.zsh
  fi
fi

# Load local configuration.
[[ -f ~/.zsh_local ]] && source ~/.zsh_local

# Load rust.
if [[ -f "$HOME/.cargo/env" ]]; then
  source "$HOME/.cargo/env"
fi

# Load nix.
if [ -e /home/rjmitchell/.nix-profile/etc/profile.d/nix.sh ]; then
  source /home/rjmitchell/.nix-profile/etc/profile.d/nix.sh;
fi
