skip_global_compinit=1

## ZSH
export ZPLUGINS="${XDG_DATA_HOME}/zsh/plugins"
export ZCOMPDUMP="${XDG_CACHE_HOME}/zsh/zcompdump-${ZSH_VERSION}"

## DEFAULT TOOLS
export EDITOR=nvim
export VISUAL=nvim
export PAGER=less
export BROWSER=vivaldi
export MANPAGER='nvim +Man!'

export RIPGREP_CONFIG_PATH="${XDG_CONFIG_HOME}/ripgrep/config"

export AWS_SHARED_CREDENTIALS_FILE="${XDG_CONFIG_HOME}/aws/credentials"
export AWS_CONFIG_FILE="${XDG_CONFIG_HOME}/aws/config"

export AZURE_CONFIG_DIR="${XDG_DATA_HOME}/azure"

export RANDFILE="${XDG_DATA_HOME}/openssl/rnd"
export GNUPGHOME="${XDG_DATA_HOME}/gnupg"
export CUDA_CACHE_PATH="${XDG_CACHE_HOME}/nv"
export WGETRC="${XDG_CONFIG_HOME}/wget/wgetrc"

export CARGO_HOME="${XDG_DATA_HOME}/cargo"

export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc"

export FAST_WORK_DIR="${XDG_CONFIG_HOME}/fsh"

export FZF_DEFAULT_COMMAND="fd --type f --strip-cwd-prefix --hidden --follow --exclude .git"
