# Dot Files

## Safe Installation

  * Download the install script from
    <https://raw.githubusercontent.com/rymitch/dotfiles/master/install>.

  * Inspect the script carefully. Executing it will clone
    the git repository and then overwrite your dotfiles!

  * When satisfied, execute the script:

    ```./install --force```

  * To change the location of the dotfiles repository:

    ```DOTFILES_REPO=/src/dotfiles ./install --force```

## Reckless Installation

**This will overwrite your existing dot files!**

    curl -fsSL https://raw.githubusercontent.com/rymitch/dotfiles/master/install | bash /dev/stdin --force
