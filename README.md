# Ryan Mitchell's Dot Files

## Installation

A script to do this automatically is coming in the future.
For now, this will work:

    git clone git@github.com:rymitch/dotfiles.git .dotfiles

    ln -s .dotfiles/bash_aliases ${HOME}/.bash_aliases
    ln -s .dotfiles/bash_cygwin ${HOME}/.bash_cygwin
    ln -s .dotfiles/bash_logout ${HOME}/.bash_logout
    ln -s .dotfiles/bashrc ${HOME}/.bashrc
    ln -s .dotfiles/gitconfig ${HOME}/.gitconfig
    ln -s .dotfiles/inputrc ${HOME}/.inputrc
    ln -s .dotfiles/minttyrc ${HOME}/.minttyrc
    ln -s .dotfiles/profile ${HOME}/.profile
    ln -s .dotfiles/screenrc ${HOME}/.screenrc
    ln -s .dotfiles/tarsnaprc ${HOME}/.tarsnaprc
    ln -s .dotfiles/vim ${HOME}/.vim
    ln -s .dotfiles/vimrc ${HOME}/.vimrc

## Why symlinks?

For several reasons, I want to avoid making my entire home
directory a git repository.

* Having my entire home directory as a git repository makes
  git attempt to [track many files](http://www.charlietanksley.net/philtex/dotfiles-and-git/)
  that I don't want versioned.
* Additionally, any child git repositories will
  [inherit the .gitignore](http://www.charlietanksley.net/philtex/dotfiles-and-git-take-2/)
  file from the $HOME repository.
* Finally, some of my dotfiles have sensitive information
  that I don't want to include in my public repository. I
  want to track those in a private repository, but there is
  not a straightforward way to have two repositories in the
  same directory.

Note that [git does not play well](http://stackoverflow.com/questions/3729278/git-and-hard-links)
with hard links, so symlinks appear to be the way to go.

## Cygwin Notes

On Windows, I like to have a directory called `C:\Projects`
where my projects are stored.

Under [Cygwin](http://www.cygwin.com/) it is natural to map
this to `/Projects`. I know of two methods:

1. Use a symbolic link: `ln -s /cygdrive/c/Projects /Projects`

   This has the disadvantage that some tools will automatically
   expand the link for display. That means the ugly `/cygdrive/c`
   can sometimes show up when I don't want it to.

2. Use a mount point.

   This seems to be the most seamless way to integrate with
   the rest of the Cygwin envrionment. Edit `/etc/fstab` and
   add the following line:

         C:/Projects /Projects ntfs binary,posix=0 0 0

   Then issue the following command to refresh the current
   mount table:

         mount -a
