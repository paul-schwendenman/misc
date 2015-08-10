bash:
	ln dotfiles/bashrc ${HOME}/.bashrc

git:
	ln dotfiles/gitconfig ${HOME}/.gitconfig

hg:
	ln dotfiles/hgrc ${HOME}/.hgrc

screen:
	ln dotfiles/screenrc ${HOME}/.screenrc

Xdefaults:
	ln dotfiles/Xdefaults ${HOME}/.Xdefaults

all: bash git hg screen Xdefaults
	@echo

