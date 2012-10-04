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

  # This is probably OSX with MacPorts, where GNU ls
  # is installed as gls.

  alias ls='LC_COLLATE=C gls -hF --color=auto --group-directories-first'
  alias dir='LC_COLLATE=C gls -ahlF --color=auto --group-directories-first'

elif [ `uname` == "Darwin" ]; then

  # OSX base install. GNU ls is not available.

  alias ls='LC_COLLATE=C ls -hFG'
  alias dir='LC_COLLATE=C ls -ahlFG'

else

  # In most other circumstances, it should be safe
  # to assume that GNU ls is available.

  alias ls='LC_COLLATE=C ls -hF --color=auto --group-directories-first'
  alias dir='LC_COLLATE=C ls -ahlF --color=auto --group-directories-first'

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

# Retrieve my external IP address.

alias myip='curl ifconfig.me'

# Count lines.

alias lncn='wc -l `find -type f -name "*"`'
