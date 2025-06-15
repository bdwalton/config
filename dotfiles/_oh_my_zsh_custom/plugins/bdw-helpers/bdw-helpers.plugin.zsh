# -*- shell-script -*-

function fake-enter() {
    print -s "$BUFFER"
    zle send-break
}

# fake-enter = save to history without executing.
zle -N fake-enter; bindkey "^X^H" fake-enter

function lc() {
    ls -h -l --color=yes $@ | less
}

function lca() {
    ls -h -l -A --color=yes $@ | less
}

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

function mcd() {
    mkdir -p $1
    cd $1
}

func sudo() {
    local _OTERM=$TERM
    export TERM=xterm-256color
    /usr/bin/sudo $@
    export TERM=$_OTERM
}

func sudosh() {
    local _OTERM=$TERM    
    export TERM=xterm-256color
    nocorrect /usr/bin/sudo $SHELL
    export TERM=$_OTERM    
}
