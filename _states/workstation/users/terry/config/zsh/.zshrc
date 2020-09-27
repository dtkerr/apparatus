#!/usr/bin/zsh
autoload -Uz compinit promptinit history-search-end
compinit; promptinit;
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

# prompt
setopt PROMPT_SUBST
kube_context () {
    local context
    context=$(kubectl config current-context 2>/dev/null)
    if [[ $? == 0 ]]; then
        context="${context}"
    else
        context=""
    fi
    echo "$context"
}
function precmd {
	export LAST_STATUS="$?"
    export KUBE_CONTEXT="$(kube_context)"
    if branch="$(git rev-parse --abbrev-ref HEAD 2> /dev/null)"; then 
        export GIT_BRANCH="$branch"
    else
        unset GIT_BRANCH
    fi
}
PROMPT="\$(/home/terry/.config/zsh/prompt.lua)"


# aliases
alias ip="ip -c"
alias ls="ls --color=auto"
alias ssh="TERM=xterm-256color ssh"
alias pacman="sudo pacman"

# environment
export PATH="$PATH:$HOME/.local/bin"
export EDITOR=/usr/bin/nvim
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export GDK_BACKEND=wayland
export MOZ_ENABLE_WAYLAND=1
export VIRTUAL_ENV_DISABLE_PROMPT=1

# ssh agent
export GPG_TTY=$(tty)
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
    export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi
gpg-connect-agent updatestartuptty /bye >/dev/null

# history
HISTSIZE=8388608
SAVEHIST=8388608
HISTFILE="$HOME/.cache/zsh_hist"
setopt inc_append_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_save_no_dups

# keybindings
bindkey -e
bindkey "^[[A"  history-beginning-search-backward-end # UP
bindkey "^[[B"  history-beginning-search-forward-end  # DOWN
bindkey "^[[H"  beginning-of-line                     # HOME
bindkey "^[[F"  end-of-line                           # END
bindkey "^[[3~" delete-char                           # DELETE

# plugins
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
