# Sorcing files
source "$HOME/.config/shell/aliasrc"

# vi-mode
bindkey -v
function zle-keymap-select () {
  case $KEYMAP in
    vicmd) echo -ne '\e[1 q';;      # block
    viins|main) echo -ne '\e[5 q';; # beam
  esac
}
zle -N zle-keymap-select
export KEYTIMEOUT=1

autoload -U colors && colors	# Load colors
setopt autocd		# Automatically cd into typed directory.
stty stop undef		# Disable ctrl-s to freeze terminal.
setopt interactive_comments
setopt HIST_IGNORE_SPACE
zle_highlight=('paste:none')
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE=~/.cache/zsh/history

# Basic auto/tab complete:
autoload -Uz compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots) # Include hidden files.

function zsh_add_file() {
    [ -f "$ZDOTDIR/$1" ] && source "$ZDOTDIR/$1"
}

zsh_add_file "zsh-prompt"

# AUR
zsh_add_file "complist/key-bindings.zsh"
[ ! -x /usr/bin/yay ] && [ -x /usr/bin/paru ] && alias yay='paru'
[ -f "$HOME"/.config/lf/icons ] && source "$HOME"/.config/lf/icons

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# auto-suggestion
bindkey '\e[C' forward-char # ➡️
ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS=(forward-char)
bindkey '\033[1;3C' forward-word # alt+ ➡️
ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=(forward-word)

# lf-cd
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp" >/dev/null
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'

export PATH="$PATH:$HOME/.local/lib/lua-language-server/bin"
#pyenv
export PATH="$PATH:$PYENV_ROOT/bin"
eval "$(pyenv init --path)"

# Load plugins
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null
source /usr/share/zsh/plugins/z/z.sh 2>/dev/null
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
