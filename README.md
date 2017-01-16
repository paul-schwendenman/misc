misc
====

This repository is mostly configuration files (dotfiles), some miscellaneous
scripts and documentation.

To install the configuration files use::

    script/bootstrap


## Atom

To install atom packages:

    apm install --packages-file $HOME/.atom/package-list.txt

To generate package list:

    apm list --installed --bare > $HOME/.atom/package-list.txt
