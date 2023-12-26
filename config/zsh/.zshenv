## ZSH
export ZCUSTOM="${XDG_DATA_HOME}/zsh"
export ZCOMPDUMP="${XDG_CACHE_HOME}/zsh/zcompdump-${ZSH_VERSION}"

## DEFAULT TOOLS
export EDITOR=lvim
export VISUAL=lvim
export PAGER=less
export MANPAGER='lvim +Man!'

## RIPGREP
export RIPGREP_CONFIG_PATH="${XDG_CONFIG_HOME}/ripgrep/config"

## AWS
export AWS_SHARED_CREDENTIALS_FILE="${XDG_CONFIG_HOME}/aws/credentials"
export AWS_CONFIG_FILE="${XDG_CONFIG_HOME}/aws/config"

## AZURE
export AZURE_CONFIG_DIR="${XDG_DATA_HOME}/azure"

## MISC
export RANDFILE="${XDG_DATA_HOME}/openssl/rnd"
export GNUPGHOME="${XDG_DATA_HOME}/gnupg"
export CUDA_CACHE_PATH="${XDG_CACHE_HOME}/nv"
export WGETRC="${XDG_CONFIG_HOME}/wget/wgetrc"

export CARGO_HOME="${XDG_DATA_HOME}/cargo"

export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc"
