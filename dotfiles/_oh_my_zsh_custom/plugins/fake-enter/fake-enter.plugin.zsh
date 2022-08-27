# -*- shell-script -*-

fake-enter() {
    print -s "$BUFFER"
    zle send-break
}

# fake-enter = save to history without executing.
zle -N fake-enter; bindkey "^X^H" fake-enter
