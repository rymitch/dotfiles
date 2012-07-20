# For privacy, clear the screen and
# history when leaving the console.

if [ "$SHLVL" = 1 ]; then
  history -c
  cat /dev/null > ~/.bash_history
  [ -x /usr/bin/clear ] && /usr/bin/clear
fi
