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
alias cp='rsync -ah --info=progress2'

## TOOLS
alias nv='nvim'
alias lv='lvim'
alias ed='$EDITOR'

alias ls='eza --icons --group-directories-first -la'
alias tldt='tealdeer'
alias duf='duf --theme ansi'

## MISC

# Enable aliases to be sudo’ed
alias sudo='doas '
alias myip='curl ipinfo.io/ip'
alias nvidia-settings='nvidia-settings --config=$XDG_CONFIG_HOME/nvidia/settings'
alias wifi-fix='sudo modprobe -r ath10k_pci && sudo modprobe ath10k_pci'

## GIT
alias ga='git add'
alias gb='git branch'
alias gbd='git branch --delete'
alias gc='git commit --verbose'
alias gco='git checkout'
alias gcor='git checkout --recurse-submodules'
alias grset='git remote set-url'
alias gcl='git clone --recurse-submodules'
alias gst='git status'

