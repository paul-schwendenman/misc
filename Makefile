help:
	@echo 'Makefile for setting up the dotfiles                         '
	@echo '                                                             '
	@echo 'Usage:                                                       '
	@echo '   make bash                        copy bashrc to home      '
	@echo '   make git                         copy gitconfig to home   '
	@echo '   make hg                          copy hgrc to home        '
	@echo '   make screen                      copy screenrc to home    '
	@echo '   make fish                        copy fish config to home '
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

fish:
	mkdir -p ${HOME}/config/fish/
	ln dotfiles/config.fish ${HOME}/config/fish/config.fish

all: bash git hg screen Xdefaults
	@echo

clean:
	rm ${HOME}/.bashrc
	rm ${HOME}/.gitconfig
	rm ${HOME}/.hgrc
	rm ${HOME}/.screenrc
	rm ${HOME}/.Xdefaults
	rm ${HOME}/.config/fish/config.fish

backup:
	touch -a ${HOME}/.bashrc dotfiles/bashrc
	touch -a ${HOME}/.gitconfig dotfiles/gitconfig
	touch -a ${HOME}/.hgrc dotfiles/hgrc
	touch -a ${HOME}/.screenrc dotfiles/screenrc
	touch -a ${HOME}/.Xdefaults dotfiles/Xdefaults
	touch -a ${HOME}/.config/fish/config.fish dotfiles/config.fish
	rm dotfiles/bashrc
	rm dotfiles/gitconfig
	rm dotfiles/hgrc
	rm dotfiles/screenrc
	rm dotfiles/Xdefaults
	rm dotfiles/config.fish
	ln ${HOME}/.bashrc dotfiles/bashrc
	ln ${HOME}/.gitconfig dotfiles/gitconfig
	ln ${HOME}/.hgrc dotfiles/hgrc
	ln ${HOME}/.screenrc dotfiles/screenrc
	ln ${HOME}/.Xdefaults dotfiles/Xdefaults
	ln ${HOME}/.config/fish/config.fish dotfiles/config.fish
