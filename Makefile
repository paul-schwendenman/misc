help:
	@echo 'Makefile for setting up the dotfiles                         '
	@echo '                                                             '
	@echo 'Usage:                                                       '
	@echo '   make bash                        copy bashrc to home      '
	@echo '   make git                         copy gitconfig to home   '
	@echo '   make hg                          copy hgrc to home        '
	@echo '   make screen                      copy screenrc to home    '
	@echo '   make Xdefaults                   copy Xdefaults to home   '
	@echo '                                                             '
	@echo '   make all                         copy all dotfiles to home'
	@echo '                                                             '

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

backup:
	touch dotfiles/bashrc
	touch dotfiles/gitconfig
	touch dotfiles/hgrc
	touch dotfiles/screenrc
	touch dotfiles/Xdefaults
	rm dotfiles/bashrc
	rm dotfiles/gitconfig
	rm dotfiles/hgrc
	rm dotfiles/screenrc
	rm dotfiles/Xdefaults
	ln ${HOME}/.bashrc dotfiles/bashrc
	ln ${HOME}/.gitconfig dotfiles/gitconfig
	ln ${HOME}/.hgrc dotfiles/hgrc
	ln ${HOME}/.screenrc dotfiles/screenrc
	ln ${HOME}/.Xdefaults dotfiles/Xdefaults
