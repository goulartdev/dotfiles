#!/usr/bin/env zsh

source ${ZDOTDIR}/lib/keys.zsh

bindkey -v # use vim key bindings, set main mode to viins

KEYTIMEOUT=1

# allow ctrl-p, ctrl-n for navigate history (standard behaviour)
#bindkey '^P' up-history                           # ctrl-p
#bindkey '^N' down-history                         # ctrl-n

autoload -Uz up-line-or-beginning-search; zle -N up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search; zle -N down-line-or-beginning-search

bindkey -M viins "${keys[Up]}" up-line-or-beginning-search
bindkey -M viins "${keys[Down]}" down-line-or-beginning-search

bindkey "${keys[Home]}"        vi-beginning-of-line
bindkey "${keys[End]}"         vi-end-of-line
bindkey "${keys[Insert]}"      vi-insert
bindkey "${keys[Backspace]}"   vi-backward-delete-char
bindkey "${keys[Delete]}"      vi-delete-char
bindkey "${keys[Left]}"        vi-backward-char
bindkey "${keys[Right]}"       vi-forward-char
bindkey "${keys[PageUp]}"      beginning-of-buffer-or-history
bindkey "${keys[PageDown]}"    end-of-buffer-or-history
bindkey "${keys[Shift+Tab]}"   reverse-menu-complete
bindkey "${keys[Ctrl+Left]}"   vi-backward-word
bindkey "${keys[Ctrl+Right]}"  vi-forward-word
bindkey "${key[PageUp]}"       beginning-of-history
bindkey "${key[PageDown]}"     end-of-history

bindkey '^w' backward-kill-word
bindkey '^u' backward-kill-line

bindkey "^k" push-input
bindkey "^[." insert-last-word

# Use vim keys in tab complete menu
bindkey -M menuselect 'left'  vi-backward-char
bindkey -M menuselect 'down'  vi-down-line-or-history
bindkey -M menuselect 'up'    vi-up-line-or-history
bindkey -M menuselect 'right' vi-forward-char

# Emulation of https://github.com/tpope/vim-surround
# Check compatibility with syntax highlight https://github.com/zsh-users/zsh-syntax-highlighting/tree/feature/redrawhook
autoload -Uz surround
zle -N delete-surround surround
zle -N add-surround surround
zle -N change-surround surround

bindkey -M vicmd cs change-surround
bindkey -M vicmd ds delete-surround
bindkey -M vicmd ys add-surround
bindkey -M visual S add-surround

# Edit current command line in vim (vim mode, then ctrl+v)
autoload -Uz edit-command-line; zle -N edit-command-line
bindkey -M vicmd '^v' edit-command-line

# Vi text-objects for brackets and quotes
autoload -Uz select-bracketed select-quoted
zle -N select-quoted
zle -N select-bracketed

for km in viopp visual; do
  for c in {a,i}${(s..)^:-\'\"\`\|,./:;=+@}; do
    bindkey -M $km $c select-quoted
  done
  
  for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
    bindkey -M $km $c select-bracketed
  done
done