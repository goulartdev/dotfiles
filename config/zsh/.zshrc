# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

## enable profiling
# zmodload zsh/zprof

######################################################################
## NAVIGATION

DIRSTACKSIZE=20

setopt AUTO_CD              # Go to folder path without using cd.
setopt AUTO_PUSHD           # Push the old directory onto the stack on cd.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_MINUS          # Navigate in stack with cd +/- (e.g. cd +1)
setopt EXTENDED_GLOB        # Use extended globbing syntax

######################################################################
## HISTORY

HISTFILE=/dev/null
HISTDB_FILE="${XDG_STATE_HOME}/zsh/history.db"

######################################################################
## COMPLETIONS

# https://github.com/sorin-ionescu/prezto/blob/master/modules/completion/init.zsh
# https://github.com/robbyrussell/oh-my-zsh/blob/master/lib/completion.zsh

if [[ -f "${ZPLUGINS}/nix-zsh-completions/nix-zsh-completions.plugin.zsh" ]]; then
  source ${ZPLUGINS}/nix-zsh-completions/nix-zsh-completions.plugin.zsh
  fpath=( "${ZPLUGINS}/nix-zsh-completions" $fpath )
fi

setopt COMPLETE_IN_WORD  # Complete from both ends of a word.
setopt ALWAYS_TO_END     # Move cursor to the end of a completed word.
setopt AUTO_MENU         # Show completion menu on successive tab press
setopt AUTO_LIST         # Automatically list choices on ambiguous completion.
setopt AUTO_PARAM_SLASH  # If completed parameter is a directory, add a trailing slash.

unsetopt MENU_COMPLETE   # Automatically highlight first element of completion menu
unsetopt FLOWCONTROL     # Disable start/stop characters in shell editor.
unsetopt CASE_GLOB       # Makes globbing (filename generation) case-sensitive 

zmodload zsh/complist # give access to menuselect keymap; should be called before compinit
autoload -Uz compinit 

if [[ -n ${ZCOMPDUMP}(#qN.mh+24) ]]; then
  rm $ZCOMPDUMP && compinit -d $ZCOMPDUMP
else
  compinit -C -d $ZCOMPDUMP
fi

_comp_options+=(globdots) # with hidden files

source ${ZDOTDIR}/lib/zstyles.zsh

autoload -U +X bashcompinit && bashcompinit # automatically load bash completion functions

######################################################################
## ALIASES

source ${ZDOTDIR}/lib/aliases.zsh

######################################################################
## autoload functions

fpath=("${ZDOTDIR}/functions" $fpath)

for func in ${ZDOTDIR}/functions/*; do
  autoload -Uz ${func:t}
done

######################################################################
## PLUGINS

source ${ZPLUGINS}/zsh-autosuggestions/zsh-autosuggestions.zsh
source ${ZPLUGINS}/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source ${ZPLUGINS}/zsh-vi-mode/zsh-vi-mode.zsh

if [[ -f "${ZPLUGINS}/zsh-nix-shell/nix-shell.plugin.zsh" ]]; then
    source ${ZPLUGINS}/zsh-nix-shell/nix-shell.plugin.zsh
fi

eval "$(atuin init zsh)"
eval "$(zoxide init zsh)"

autoload -Uz add-zsh-hook

# This will find the most frequently issued command issued exactly in this directory, 
# or if there are no matches it will find the most frequently issued command in any directory. 
_zsh_autosuggest_strategy_atuin_search() {
  suggestion=$(atuin search --cmd-only --limit 1 --search-mode prefix $1)
}

ZSH_AUTOSUGGEST_STRATEGY=atuin_search
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#7f848e"

if command -v fzf &> /dev/null; then
  if [[ -f /usr/share/fzf/completion.zsh ]]; then
    source /usr/share/fzf/completion.zsh
  fi
  if [[ -f /usr/share/fzf/key-bindings.zsh ]]; then
    source /usr/share/fzf/key-bindings.zsh
  fi

  export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
    --color=fg:#dfebed,fg+:#dfebed,bg:#010909,bg+:#192323
    --color=hl:#3a5fd4,hl+:#008b8b,info:#dfebed,marker:#d86818
    --color=prompt:#226622,spinner:#d86818,pointer:#3a5fd4,header:#dfebed
    --color=gutter:#010909,border:#663399,preview-fg:#dfebed,preview-bg:#010909
    --color=label:#dfebed,query:#dfebed
    --border="rounded" --border-label="" --preview-window="border-rounded" --prompt=" "
    --marker="" --pointer="◆" --separator="─" --scrollbar="▌" --info="right"'
fi

######################################################################
## prompt

source ${ZPLUGINS}/powerlevel10k/powerlevel10k.zsh-theme
source ${ZDOTDIR}/lib/p10k.zsh

# zprof
