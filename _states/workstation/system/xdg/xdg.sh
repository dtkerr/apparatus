#!/bin/sh
# try to convince various applications to respect the
# XDG user directories for config / cache/ data
# https://wiki.archlinux.org/index.php/XDG_Base_Directory_support

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local"

export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
export IPYTHONDIR="$XDG_CONFIG_HOME/jupyter"
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME/jupyter"
export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME/bundle"
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export LESSKEY="$XDG_CONFIG_HOME/lesskey"

export CARGO_HOME="$XDG_DATA_HOME/cargo"
export GOPATH="$XDG_DATA_HOME/go"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export GEM_HOME="$XDG_DATA_HOME/gem"
export WORKON_HOME="$XDG_DATA_HOME/venvs"

export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"
export LESSHISTFILE="$XDG_CACHE_HOME/less-hist"
export NODE_REPL_HISTORY="$XDG_CACHE_HOME/node-hist"
export RANDFILE="$XDG_CACHE_HOME/rnd"
export GEM_SPEC_CACHE="$XDG_CACHE_HOME/gem"
