# -*- shell-script -*-

# Launch a new titled tmux window that ssh's to the designated host We
# force the use of our shell in what should avoid login mode (which
# would trigger)
function tmw() {
    if [[ -z "${TMUX}" ]]; then
	print "Not running in tmux..."
	return
    fi
    local _host=$1
    local _shorthost=${_host%%.*}
    tmux new-window -n ${_shorthost} "ssh ${_host}"
}
