misc
====

This repository is mostly configuration files (dotfiles), some miscellaneous
scripts and documentation.

To install the most common configuration files use::

    ./bootstrap

Which will install bash, git and vim dotfiles, to install all dotfiles run::

    stow -t $HOME */

Ignore changes::

    git update-index --skip-worktree path/to/file
