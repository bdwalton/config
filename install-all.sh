#!/bin/bash

set -e

for setup_script in ./scripts/*; do
    $setup_script
done

./install-dotfiles.py
