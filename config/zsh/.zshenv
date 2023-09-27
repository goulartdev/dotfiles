export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"
export XDG_RUNTIME_DIR="/run/user/$(id -u)"

#path=("${HOME}/.local/{bin,sbin}" $path)

## ZSH
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"
export ZDATADIR="${XDG_DATA_HOME}/zsh"
export ZCOMPDUMP="${XDG_CACHE_HOME}/zsh/zcompdump-${ZSH_VERSION}"

## DEFAULT TOOLS
export EDITOR=lvim
export VISUAL=lvim
export PAGER=less
export MANPAGER='lvim +Man!'

## NIX
export NIX_PATH=${NIX_PATH:+$NIX_PATH:}${XDG_STATE_HOME}/nix/defexpr/channels

## MISC
export RANDFILE="${XDG_DATA_HOME}/openssl/rnd"
export GNUPGHOME="${XDG_DATA_HOME}/gnupg"
export CUDA_CACHE_PATH="${XDG_CACHE_HOME}/nv"
export WGETRC="${XDG_CONFIG_HOME}/wget/wgetrc"

## ASDF
export ASDF_DIR="${XDG_DATA_HOME}/asdf"
export ASDF_DATA_DIR="${XDG_DATA_HOME}/asdf"
export ASDF_CONFIG_FILE="${XDG_CONFIG_HOME}/asdf/asdfrc"

## MICROMAMBA
export MAMBA_ROOT_PREFIX="${XDG_DATA_HOME}/mamba"
export MAMBA_EXE="${MAMBA_ROOT_PREFIX}/bin/micromamba";
export CONDA_ENVS_DIRS="${MAMBA_ROOT_PREFIX}/envs"
export CONDA_PKGS_DIRS="${XDG_CACHE_HOME}/mamba/pkgs"
export MAMBARC="${XDG_CONFIG_HOME}/mamba/mambarc"

## DOCKER
export DOCKER_CONFIG="${XDG_CONFIG_HOME}/docker"
export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1

## PSQL
export PSQLRC="${XDG_CONFIG_HOME}/psql/psqlrc"
export PSQL_HISTORY="${XDG_STATE_HOME}/psql/psql_history"
export PGPASSFILE="${XDG_CONFIG_HOME}/psql/pgpass"
export PGSERVICEFILE="${XDG_CONFIG_HOME}/psql/pg_service.conf"

## RIPGREP
export RIPGREP_CONFIG_PATH="${XDG_CONFIG_HOME}/ripgrep/config"

## CARGO
export CARGO_HOME="${XDG_DATA_HOME}/cargo"

## NODE / NPM
export NODE_REPL_HISTORY="${XDG_CACHE_HOME}/node/node_repl_history"
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc"

## PYTHON
export PYTHONSTARTUP="${XDG_CONFIG_HOME}/python/python_history.py"
export PYLINTHOME="${XDG_CACHE_HOME}/pylint"
export PYTHON_EGG_CACHE="${XDG_CACHE_HOME}/python-eggs"
export PIPENV_DONT_LOAD_ENV=0
export PIPENV_VENV_IN_PROJECT=1

## AWS
export AWS_SHARED_CREDENTIALS_FILE="${XDG_CONFIG_HOME}/aws/credentials"
export AWS_CONFIG_FILE="${XDG_CONFIG_HOME}/aws/config"

## AZURE
export AZURE_CONFIG_DIR="${XDG_DATA_HOME}/azure"

## VSCODE 
# devcontainer UID GID
#export UID=$UID
#export GID=$GID
