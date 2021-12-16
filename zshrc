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

# .NET configuration.
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export PATH="$PATH:$HOME/.dotnet/tools/"

# Set the default editor and pager.
export EDITOR=vi
export PAGER=less

# Configure the nvm plugin.
export NVM_LAZY_LOAD=true

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
  zgenom load lukechilds/zsh-nvm
  zgenom load mattberther/pyenv
  zgenom load romkatv/powerlevel10k powerlevel10k
  zgenom load zsh-users/zsh-completions
  zgenom load zsh-users/zsh-syntax-highlighting
  zgenom ohmyzsh plugins/gitfast
  zgenom ohmyzsh plugins/ssh-agent
  zgenom ohmyzsh plugins/web-search
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
bindkey -v

# Aliases
alias bc='bc -l' # enable floating point math
alias clear='printf "\033c"'
alias cls='printf "\033c"'
alias df='df -hx "squashfs"'
alias dir='LC_COLLATE=C ls -ahlLN --color=auto --group-directories-first'
alias du='du -h'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias ls='LC_COLLATE=C ls -hN --color=auto --group-directories-first'
alias azurite-clean='rm -rf ~/.azurite && mkdir -p ~/.azurite && azurite --location ~/.azurite --debug ~/.azurite/debug.log'

# Customize Powerlevel10k. To customize, either
# run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

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
