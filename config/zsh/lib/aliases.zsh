#!/usr/bin/env zsh

## NAVIGATION

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

alias -- -='cd -'

# dir stack (e.g. 1/some/pash => cd -1/some/path)
for index ({1..9}) alias "${index}"="cd -${index} > /dev/null"; unset index

## DIR/FILE MANIPULATION

alias mkd='mkdir -pv'
alias rmd='rm -rf'
# Copy with progress bar
alias cp='rsync -ah --info=progress2'

## TOOLS
alias vim='lvim'
alias nvim='lvim'
alias edit='$EDITOR'

alias umamba='micromamba'

alias grep='rg'
alias cat='bat --style=auto'
alias ls='lsd --icon=always --group-dirs=first -la '
alias find='fd'
alias ps='procs'
alias sed='sd'
alias grep='rg'
alias top='btm'
alias tldt='tealdeer'

## MISC

# Enable aliases to be sudo’ed
alias sudo='sudo '
alias myip='curl ipinfo.io/ip'
alias hsi='history | grep -i'

## GIT
alias ga='git add'
alias gb='git branch'
alias gbd='git branch --delete'
alias gc='git commit --verbose'
alias gco='git checkout'
alias gcor='git checkout --recurse-submodules'
alias grset='git remote set-url'
alias gcl='git clone --recurse-submodules'

alias duf=duf --theme ansi
