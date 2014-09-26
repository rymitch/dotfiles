# Dot Files

## Installation

A script to do this automatically is coming in the future.
For now, this will work:

    git clone git://github.com/rymitch/dotfiles.git .dotfiles

    ln -s .dotfiles/bash_aliases ${HOME}/.bash_aliases
    ln -s .dotfiles/bash_cygwin ${HOME}/.bash_cygwin
    ln -s .dotfiles/bash_logout ${HOME}/.bash_logout
    ln -s .dotfiles/bashrc ${HOME}/.bashrc
    ln -s .dotfiles/bin ${HOME}/bin
    ln -s .dotfiles/emacs.d ${HOME}/.emacs.d
    ln -s .dotfiles/gitconfig ${HOME}/.gitconfig
    ln -s .dotfiles/hgrc ${HOME}/.hgrc
    ln -s .dotfiles/inputrc ${HOME}/.inputrc
    ln -s .dotfiles/minttyrc ${HOME}/.minttyrc
    ln -s .dotfiles/profile ${HOME}/.profile
    ln -s .dotfiles/screenrc ${HOME}/.screenrc
    ln -s .dotfiles/startxwinrc ${HOME}/.startxwinrc
    ln -s .dotfiles/tarsnaprc ${HOME}/.tarsnaprc
    ln -s .dotfiles/tmux.conf ${HOME}/.tmux.conf
    ln -s .dotfiles/vim ${HOME}/.vim
    ln -s .dotfiles/vimrc ${HOME}/.vimrc
    ln -s .dotfiles/Xdefaults ${HOME}/.Xdefaults
    ln -s .dotfiles/XWinrc ${HOME}/.XWinrc

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
