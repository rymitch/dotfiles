# If bash, then load bashrc.

if [ -n "$BASH_VERSION" ] ; then
    if [ -e "${HOME}/.bashrc" ] ; then
        source "${HOME}/.bashrc"
    fi
else
    if [ -d /opt/sbin ] ; then
        export PATH=/opt/sbin:$PATH
    fi
    if [ -d /opt/bin ] ; then
        export PATH=/opt/bin:$PATH
    fi
fi
