# If bash, then load bashrc.

if [ -n "$BASH_VERSION" ] ; then
    if [ -e "${HOME}/.bashrc" ] ; then
        source "${HOME}/.bashrc"
    fi
fi
