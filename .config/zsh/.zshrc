# Options
autoload -U colors && colors   # Load colors
setopt autocd           # Automatically cd into typed directory.
stty stop undef         # Disable ctrl-s to freeze terminal.
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

# Sorcing files
[ -f "$ZDOTDIR/zsh-prompt" ] && source "$ZDOTDIR/zsh-prompt"
# [ -f "$ZDOTDIR/complist/key-bindings.zsh" ] && source "$ZDOTDIR/complist/key-bindings.zsh"
# [ -f "${XDG_CONFIG_HOME}/shell/shortcutrc" ] && source "${XDG_CONFIG_HOME}/shell/shortcutrc"
[ -f "${XDG_CONFIG_HOME}/shell/aliasrc" ] && source "${XDG_CONFIG_HOME}/shell/aliasrc"
[ -f "${XDG_CONFIG_HOME}/lf/icons" ] && source "${XDG_CONFIG_HOME}/lf/icons"

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# auto-suggestion
bindkey '\e[C' forward-char # ➡️
ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS=(forward-char)
bindkey '\033[1;3C' forward-word # alt+ ➡️
ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=(forward-word)

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
# echo -ne '\e[5 q' # Use beam shape cursor on startup.
# preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

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
bindkey -s '^f' 'cd "$(dirname "$(fzf)")"\n'

# PATH change
# export PATH="$PATH:$PYENV_ROOT/bin"
# eval "$(pyenv init --path)"

# Load plugins
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null
source /usr/share/zsh/plugins/z/z.sh 2>/dev/null
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
