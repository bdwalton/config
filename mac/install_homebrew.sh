#!/bin/bash

cd ~
if [ ! -d ~/homebrew ]; then
		echo "Installing Homebrew..."
		mkdir homebrew
		curl -L https://github.com/mxcl/homebrew/tarball/master | \
				tar xz --strip 1 -C homebrew
else
		echo "Not installing Homebrew. ~/homebrew already exists."
fi
