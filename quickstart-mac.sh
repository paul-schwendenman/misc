#!/usr/bin/env bash
#
# Setup a new mac

echo ''

info () {
  printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}

user () {
  printf "\r  [ \033[0;33m??\033[0m ] $1\n"
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit
}

info 'installing homebrew'
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

info 'installing packages'

brew install \
	bash \
	bash-completion \
	git \
	gnupg2 \
	joe \
	pass \
	pinentry \
	python \
	python3 \
	pipenv \
	vim

brew cask install \
	firefox \
	google-chrome \
	shiftit

info 'changing user shell to brew bash'

# if ! grep '/usr/local/bin/bash' /etc/shells; then

#   echo '/usr/local/bin/bash' | sudo tee -a /etc/shells;
#   chsh -s /usr/local/bin/bash;
# fi;

if ! grep '/opt/homebrew/bin/bash' /etc/shells; then

  echo '/opt/homebrew/bin/bash' | sudo tee -a /etc/shells;
  chsh -s /opt/homebrew/bin/bash;
fi;
