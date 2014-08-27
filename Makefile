bash:
	cp dotfiles/bashrc ${HOME}/.bashrc

git:
	cp dotfiles/gitconfig ${HOME}/.gitconfig

hg:
	cp dotfiles/hgrc ${HOME}/.hgrc

screen:
	cp dotfiles/screenrc ${HOME}/.screenrc

Xdefaults:
	cp dotfiles/Xdefaults ${HOME}/.Xdefaults

all: bash git hg screen Xdefaults
	@echo 