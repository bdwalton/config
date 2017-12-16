#!/bin/bash

set -e

if [ ! -f ~/.bdwconfig ]; then
	echo "Please create ~/.bdwconfig"
	exit 1
fi

for setup_script in ./scripts/*; do
    $setup_script
done

./install-dotfiles.py
