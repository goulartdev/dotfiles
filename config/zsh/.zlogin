# Execute code in the background to not affect the current session
(
  # needed for devcontainer ssh forwarding
  if [ -z "$SSH_AUTH_SOCK" ]; then
    # Check for a currently running instance of the agent
    RUNNING_AGENT="`ps -ax | grep 'ssh-agent -s' | grep -v grep | wc -l | tr -d '[:space:]'`"
    
    if [ "$RUNNING_AGENT" = "0" ]; then
      # Launch a new instance of the agent
      ssh-agent -s &> $HOME/.ssh/ssh-agent
    fi

    eval `cat $HOME/.ssh/ssh-agent`
  fi

  # <https://github.com/zimfw/zimfw/blob/master/login_init.zsh>
  setopt LOCAL_OPTIONS EXTENDED_GLOB
  autoload -Uz zrecompile

  # Compile zcompdump, if modified, to increase startup speed.
  if [[ -s "$ZCOMPDUMP" && (! -s "${ZCOMPDUMP}.zwc" || "$ZCOMPDUMP" -nt "${ZCOMPDUMP}.zwc") ]]; then
    if command mkdir "${ZCOMPDUMP}.zwc.lock" 2>/dev/null; then
      zrecompile -pq "$ZCOMPDUMP"
      command rmdir "${ZCOMPDUMP}.zwc.lock" 2>/dev/null
    fi
  fi

  zrecompile -pq ${ZDOTDIR}/.zshrc
  zrecompile -pq ${ZDOTDIR}/.zprofile
  zrecompile -pq ${ZDOTDIR}/.zshenv

  # recompile all zsh or sh
  for f in {$ZDOTDIR,$ZDATADIR/plugins}/**/*.*sh; do
    zrecompile -pq $f
  done
) &!
