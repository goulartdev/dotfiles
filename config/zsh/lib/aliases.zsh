#!/usr/bin/env zsh

## NAVIGATION

alias cd="zd"

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
alias vim='nvim'

alias ls='eza --icons --group-directories-first -la'
alias lt='eza --tree --level=2 --long --icons --git'
alias duf='duf --theme ansi'
alias ff="fzf --preview 'bat --style=numbers --color=always {}'"

## MISC

# Enable aliases to be sudo’ed
alias sudo='doas '
alias myip='curl ipinfo.io/ip'
alias nvidia-settings='nvidia-settings --config=$XDG_CONFIG_HOME/nvidia/settings'
alias wifi-fix='sudo modprobe -r ath10k_pci && sudo modprobe ath10k_pci'

alias develop='nix develop -c zsh'

## GIT
alias ga='git add'
alias gun='git reset -- '
alias gb='git branch'
alias gbd='git branch --delete'
alias gc='git commit --verbose'
alias gco='git checkout'
alias gcor='git checkout --recurse-submodules'
alias grset='git remote set-url'
alias gcl='git clone --recurse-submodules'
alias gst='git status'
alias gsl='git stash list --date=local'
alias gw='git worktree'
alias gbt='git branch --set-upstream-to=origin/$(git rev-parse --abbrev-ref HEAD) $(git rev-parse --abbrev-ref HEAD)'
alias lg='lazygit'

alias news='newsboat --quiet'
