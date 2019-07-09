#!/usr/bin/env bash
#
# install things


# oh-my-zsh 
###############################################################################
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"


# PYENV
###############################################################################
CFLAGS="-I$(xcrun --show-sdk-path)/usr/include"

# install pyenv
git -C "$PYENV_ROOT" pull || git clone https://github.com/pyenv/pyenv.git "$PYENV_ROOT"

# install pyenv-virtualenv plugin
git -C "$PYENV_ROOT/plugins/pyenv-virtualenv" || git clone https://github.com/pyenv/pyenv-virtualenv.git "$PYENV_ROOT/plugins/pyenv-virtualenv"

# initialize
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# install versions of python
env PYTHON_CONFIGURE_OPTS="--enable-framework" pyenv install 3.6.7


# homebrew
###############################################################################
if ! command -v brew; then
    echo; echo -e "Installing Homebrew ..."; echo
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade


# brew software installs
###############################################################################

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils

# Install `wget` with IRI support.
brew install wget --with-iri

# Install GnuPG to enable PGP-signing commits.
brew install gnupg

# Install more recent versions of some macOS tools.
brew install openssh

# Install other useful binaries.
brew install git
brew install git-lfs
brew install imagemagick --with-webp
brew install pandoc
brew install php-code-sniffer

# Pipenv
brew install pipenv

# Remove outdated versions from the cellar.
brew cleanup
