# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
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

HISTFILE="${XDG_STATE_HOME}/zsh/history"
HISTDB_FILE="${XDG_STATE_HOME}/zsh/history.db"
HISTSIZE=10000
SAVEHIST=10000

setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.

######################################################################
## COMPLETIONS

# https://github.com/sorin-ionescu/prezto/blob/master/modules/completion/init.zsh
# https://github.com/robbyrussell/oh-my-zsh/blob/master/lib/completion.zsh

fpath=("${XDG_DATA_HOME}/zsh/completions" $fpath)

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

######################################################################
## BINDINGS

source ${ZDOTDIR}/lib/bindings.zsh

######################################################################
## ALIASES

source ${ZDOTDIR}/lib/aliases.zsh

######################################################################
## PLUGINS

source ${ZDOTDIR}/plugins/zsh-histdb/zsh-histdb.plugin.zsh # TODO: try https://github.com/atuinsh/atuin: 
source ${ZDOTDIR}/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source ${ZDOTDIR}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh # TODO: try https://github.com/zdharma-continuum/fast-syntax-highlighting

autoload -Uz add-zsh-hook

# This will find the most frequently issued command issued exactly in this directory, 
# or if there are no matches it will find the most frequently issued command in any directory. 
_zsh_autosuggest_strategy_histdb_default() {
  local query="
    select commands.argv from history
    left join commands on history.command_id = commands.rowid
    left join places on history.place_id = places.rowid
    where commands.argv LIKE '$(sql_escape $1)%'
    group by commands.argv, places.dir
    order by places.dir != '$(sql_escape $PWD)', count(*) desc
    limit 1
  "
  suggestion=$(_histdb_query "$query")
}

ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none
ZSH_AUTOSUGGEST_STRATEGY=histdb_default

######################################################################
## autoload functions

fpath=("${ZDOTDIR}/functions" $fpath)

for func in ${ZDOTDIR}/functions/*; do
  autoload -Uz ${func:t}
done

######################################################################
## misc

source "$ASDF_DIR/asdf.sh"
source "$MAMBA_ROOT_PREFIX/mamba.sh"

######################################################################
## prompt

source ${ZDOTDIR}/lib/cursor-mode.zsh

source ${ZDATADIR}/plugins/powerlevel10k/powerlevel10k.zsh-theme 
source ${ZDOTDIR}/lib/p10k.zsh
