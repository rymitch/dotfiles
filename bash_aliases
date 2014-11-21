# Set the title of the terminal.

set_title () {
  echo -ne "\e]2;$@\a\e]1;$@\a" ;
}

# Returns true if the specified command exists.

command_exists () {
  type "$1" &> /dev/null ;
}

# Create a directory and chdir into it.

function mkcd () {
  mkdir -p "$@" && eval cd "\"\$$#\"" ;
}

# Aliases for 'ls'. The specific flags depend
# on whether the system has BSD ls or GNU ls.

if command_exists gls ; then

  # When GNU coreutils is installed with a
  # 'g' prefix, then use gls.

  alias ls='LC_COLLATE=C gls -hF --color=auto --group-directories-first'
  alias dir='LC_COLLATE=C gls -ahlF --color=auto --group-directories-first'

elif [ $(uname) == "Darwin" -o $(uname) == "FreeBSD" ]; then

  # BSD style options.

  alias ls='LC_COLLATE=C ls -hFG'
  alias dir='LC_COLLATE=C ls -ahlFG'

elif [ "$OSTYPE" = "cygwin" -o $(uname) == "Linux" ]; then

  # Cygwin uses GNU coreutils.

  alias ls='LC_COLLATE=C ls -hF --color=auto --group-directories-first'
  alias dir='LC_COLLATE=C ls -ahlF --color=auto --group-directories-first'

else

  # It is unclear which variant of 'ls' is
  # available. Fall back to safe defaults.

  alias ls='ls -F'
  alias dir='ls -alF'

fi

# Start a Windows explorer window in the current working
# directory.

if command_exists explorer.exe ; then
  alias explore='cygstart explorer `cygpath -aw .`'
fi

# Colorize grep output.

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Humanize files sizes.

alias df='df -h'
alias du='du -h'

# Clear the screen.

alias cls=clear

# Start tmux in 256 color mode.

alias tmux='tmux -2'

# Emacs

alias e='emacsclient -n'

# Retrieve my external IP address.

alias myip='curl ifconfig.me'
alias myhost='curl ifconfig.me/host'

# Count lines.

alias lncn='wc -l `find . -type f -name "*"`'
