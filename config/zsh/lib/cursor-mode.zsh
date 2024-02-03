#!/usr/bin/env zsh

# change cursor between modes
# See https://ttssh2.osdn.jp/manual/4/en/usage/tips/vim.html for cursors

VI_MODE_CURSOR_NORMAL=2 # steady block
VI_MODE_CURSOR_VISUAL=6 # steady beam
VI_MODE_CURSOR_INSERT=5 # blinking beam
VI_MODE_CURSOR_OPPEND=0 # blinking block

function zle-keymap-select() {
  local _shape=0
  
  case "${1:-${KEYMAP:-main}}" in
    main)    _shape=$VI_MODE_CURSOR_INSERT ;; # viins if bindkey -v, else emacs
    viins)   _shape=$VI_MODE_CURSOR_INSERT ;; # vi insert mode
    vicmd)   _shape=$VI_MODE_CURSOR_NORMAL ;; # vi noemal mode
    visual)  _shape=$VI_MODE_CURSOR_VISUAL ;; # vi visual mode
    viopp)   _shape=$VI_MODE_CURSOR_OPPEND ;; # vi operation pending
    isearch) _shape=$VI_MODE_CURSOR_INSERT ;; # inc search
    command) _shape=$VI_MODE_CURSOR_INSERT ;; # read a command name
    *)       _shape=0 ;;
  esac
  
  printf $'\e[%d q' "${_shape}"
}

function zle-line-init() {
  printf $'\e[%d q' "${VI_MODE_CURSOR_INSERT}"
}

zle -N zle-keymap-select
zle -N zle-line-init
