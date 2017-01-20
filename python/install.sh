#!/bin/bash

set -e

ROOT_PATH="$(dirname $(dirname ${BASH_SOURCE}))"
source $ROOT_PATH/lib/lib.sh

VERSION="2.7.11"

if [[ $OS == "osx" ]]; then
	brew_install readline xz
elif [[ $OS == "centos" ]]; then
	yum install -y gcc zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel openssl-devel
fi

# install pyenv
if [[ ! -d ${HOME}/.pyenv ]]; then
	curl -fsSL "https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer" | bash
	source $ROOT_PATH/python/path.zsh
    # source $ROOT_PATH/python/pyenv.zsh
	env PYTHON_CONFIGURE_OPTS="--enable-framework CC=clang" pyenv install $VERSION
	pyenv global $VERSION
fi

# install plugins
plugins=(
	virtualenv
	autopep8
	flake8
	docopt
	pytz
	requests
	unittest2
    arrow
	# thefuck
)

# update pip
pip_install_one --upgrade pip

pip_install ${plugins[@]}
