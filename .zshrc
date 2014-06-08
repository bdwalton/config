# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/bwalton/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

autoload -U colors && colors

PROMPT="%B%{$fg[green]%}%n%{$reset_color%}%b @ %B%{$fg[blue]%}%m%b %{$reset_color%}: %{$fg[red]%}%3~
%{$reset_color%}(%?) %# "
