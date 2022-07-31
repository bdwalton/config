# -*- shell-script -*-

fake-enter() {
    print -s "$BUFFER"
    zle send-break
}
