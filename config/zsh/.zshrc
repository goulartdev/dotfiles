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

# check insecure directories
autoload -Uz compaudit

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

source ${ZPLUGINS}/nix-zsh-completions/nix-zsh-completions.plugin.zsh

fpath=( "${ZPLUGINS}/nix-zsh-completions" $fpath )

setopt COMPLETE_IN_WORD  # Complete from both ends of a word.
setopt ALWAYS_TO_END     # Move cursor to the end of a completed word.
setopt AUTO_MENU         # Show completion menu on successive tab press
setopt AUTO_LIST         # Automatically list choices on ambiguous completion.
setopt AUTO_PARAM_SLASH  # If completed parameter is a directory, add a trailing slash.

unsetopt MENU_COMPLETE   # Automatically highlight first element of completion menu
unsetopt FLOWCONTROL     # Disable start/stop characters in shell editor.
unsetopt CASE_GLOB       # Makes globbing (filename generation) case-sensitive 

zmodload zsh/complist # give access to menuselect keymap; should be called before compinit
autoload -Uz compinit; compinit -d $ZCOMPDUMP
_comp_options+=(globdots) # with hidden files

source ${ZDOTDIR}/lib/zstyles.zsh

autoload -U +X bashcompinit && bashcompinit # automatically load bash completion functions

######################################################################
## BINDINGS

source ${ZDOTDIR}/lib/bindings.zsh

######################################################################
## ALIASES

source ${ZDOTDIR}/lib/aliases.zsh

######################################################################
## PLUGINS

source ${ZPLUGINS}/zsh-autosuggestions/zsh-autosuggestions.zsh
source ${ZPLUGINS}/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
#source ${ZPLUGINS}/zsh-vi-mode/zsh-vi-mode.zsh
source ${ZPLUGINS}/zsh-nix-shell/nix-shell.plugin.zsh
eval "$(atuin init zsh)"

autoload -Uz add-zsh-hook

# This will find the most frequently issued command issued exactly in this directory, 
# or if there are no matches it will find the most frequently issued command in any directory. 
_zsh_autosuggest_strategy_atuin_search() {
  suggestion=$(atuin search --cmd-only --limit 1 --search-mode prefix $1)
}

#ZSH_HIGHLIGHT_STYLES[path]=none
#ZSH_HIGHLIGHT_STYLES[path_prefix]=none
ZSH_AUTOSUGGEST_STRATEGY=atuin_search

######################################################################
## autoload functions

fpath=("${ZDOTDIR}/functions" $fpath)

for func in ${ZDOTDIR}/functions/*; do
  autoload -Uz ${func:t}
done

######################################################################
## prompt

source ${ZDOTDIR}/lib/cursor-mode.zsh
source ${ZPLUGINS}/powerlevel10k/powerlevel10k.zsh-theme
source ${ZDOTDIR}/lib/p10k.zsh
