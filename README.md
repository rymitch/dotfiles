# Ryan Mitchell's Dot Files

## Installation

A script to do this automatically is coming in the future.
For now, this will work:

    git clone git@github.com:rymitch/dotfiles.git .dotfiles

    ln -s .dotfiles/vim ${HOME}/.vim
    ln -s .dotfiles/vimrc ${HOME}/.vimrc
    ln -s .dotfiles/screenrc ${HOME}/.screenrc

## Cygwin Notes

On Windows, I like to have a directory called "C:\Projects"
where my projects are stored.

Under [Cygwin](http://www.cygwin.com/) it is natural to map
this to /Projects.

There are two ways to do this:

1. Use a symbolic link: `ln -s /cygdrive/c/Projects /Projects`

   This has the disadvantage that some tools will automatically
   expand the link for display. That means the ugly `/cygdrive/c`
   will show up when you don't want it to.

2. Use a mount point.

   This seems to integrate the most naturally with the rest
   of the Cygwin envrionment. Edit /etc/fstab and add the
   following line:

      C:/Projects /Projects ntfs binary,posix=0 0 0

   Then issue the following command to refresh the current
   mount table:

      mount -a

