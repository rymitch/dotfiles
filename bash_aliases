# Returns true if the specified command exists.

exists() { type -t "$1" > /dev/null 2>&1; }

# Aliases for 'ls'. The specific flags depend
# on whether the system has BSD ls or GNU ls.

if exists gls ; then

  # When GNU coreutils is installed with a
  # 'g' prefix, then use gls.

  alias ls='LC_COLLATE=C gls -hN --color=auto --group-directories-first'
  alias dir='LC_COLLATE=C gls -ahlLN --color=auto --group-directories-first'

elif [ $(uname) == "Darwin" -o $(uname) == "FreeBSD" ]; then

  # BSD style options.

  alias ls='LC_COLLATE=C ls -hFG'
  alias dir='LC_COLLATE=C ls -ahlFG'

elif [ "$OSTYPE" = "cygwin" -o $(uname) == "Linux" ]; then

  # Cygwin uses GNU coreutils.

  alias ls='LC_COLLATE=C ls -hN --color=auto --group-directories-first'
  alias dir='LC_COLLATE=C ls -ahlLN --color=auto --group-directories-first'

else

  # It is unclear which variant of 'ls' is
  # available. Fall back to safe defaults.

  alias ls='ls -F'
  alias dir='ls -alF'

fi

# Prefer GNU tar over BSD tar.

if exists gtar ; then
  alias tar=gtar
fi

# Start a Windows explorer window in the current working
# directory.

if exists explorer.exe ; then
  alias explore='cygstart explorer `cygpath -aw .`'
fi

# Colorize grep output.

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Humanize files sizes.

if [ $(uname) == "Darwin" -o $(uname) == "FreeBSD" ]; then
  alias df='df -h'
else
  alias df='df -hx "squashfs"'
fi
alias du='du -h'

# Floating point math in bc.

alias bc='bc -l'

# Clear the screen.

alias clear='printf "\033c"'
alias cls='printf "\033c"'

# Start tmux in 256 color mode.

alias tmux='tmux -2'

# Retrieve my external IP address.

alias myip='curl ifconfig.me'

# Make 'dirs' a little more helpful.

alias dirs='dirs -v'
