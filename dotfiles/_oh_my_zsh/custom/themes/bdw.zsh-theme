PROMPT="%B%{$fg[green]%}%n%{$reset_color%}%b @ %B%{$fg[blue]%}%m%b %{$reset_color%}: %{$fg[red]%}%3~
%{$reset_color%}(%?) %# "
RPROMPT=$'$(git_prompt_info)'


ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
