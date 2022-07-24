# -*- shell-script -*-

if [[ -n "${BDW_CONFIG_TYPE}" ]]; then
    {
	local l_ZSH_CUSTOM
	l_ZSH_CUSTOM="${ZSH}-${BDW_CONFIG_TYPE}/custom"
	echo $l_ZSH_CUSTOM
	if is_plugin "$l_ZSH_CUSTOM" "${BDW_CONFIG_TYPE}"; then
	    fpath=("$l_ZSH_CUSTOM/plugins/${BDW_CONFIG_TYPE}" $fpath)
	    source "${l_ZSH_CUSTOM}/plugins/${BDW_CONFIG_TYPE}/${BDW_CONFIG_TYPE}.plugin.zsh"
	fi
    }
fi
