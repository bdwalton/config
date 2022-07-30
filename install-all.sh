#!/bin/bash

set -e

BDWCONFIG=~/.bdwconfig

if [[ -n "$1" ]]; then
    echo "export BDW_CONFIG_TYPE=$1" >> "${BDWCONFIG}"
    echo >> "${BDWCONFIG}"
fi

if [[ ! -f "${BDWCONFIG}" ]]; then
	echo "Please create ${BDWCONFIG}"
	exit 1
fi

for setup_script in ./scripts/*; do
    $setup_script
done

cd dotfiles
./install --verbose
