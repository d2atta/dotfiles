# ~/.config/fish/config.fish
#
#    >=>                            >=>     >=>
#    >=>                        >>  >=>     >=>
#    >=>   >==>    >=>     >=>      >=>     >=>   >==>    >=>     >=>
#  >=>>=> >>   >=>   >=>   >=>  >=>  >=>  >=>>=> >>   >=>   >=>   >=>
# >>  >=> >>===>>=>   >=> >=>   >=>  >=> >>  >=> >>===>>=>   >=> >=>
# >>  >=> >>           >=>=>    >=>  >=> >>  >=> >>           >=>=>
#  >=>>=>  >====>       >=>     >=> >==>  >=>>=>  >====>       >=>
#

fish_vi_key_bindings
# Hide welcome message
set fish_greeting
set VIRTUAL_ENV_DISABLE_PROMPT "1"
set fish_cursor_insert line

## Environment setup
source ~/.config/shell/profile
source ~/.config/shell/aliasrc

# Add ~/.local/bin to PATH
if test -d ~/.local/bin
    if not contains -- ~/.local/bin $PATH
        set -p PATH ~/.local/bin
    end
end

# yay and paru
[ ! -x /usr/bin/yay ] && [ -x /usr/bin/paru ] && alias yay='paru'

## Functions #################################################
# Functions needed for !! and !$ https://github.com/oh-my-fish/plugin-bang-bang
function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

function __history_previous_command_arguments
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end

function fish_user_key_bindings
    bind ! bind_bang
end

if [ "$fish_key_bindings" = fish_vi_key_bindings ];
  bind -Minsert ! __history_previous_command
  bind -Minsert '$' __history_previous_command_arguments
else
  bind ! __history_previous_command
  bind '$' __history_previous_command_arguments
end

function backup --argument filename
    cp $filename $filename.bak
end
################################################################


## Starship prompt
if [ "$TERM" != "linux" ]; 
   source (starship init fish --print-full-init | psub)
   source (zoxide init fish | psub)
end
# vim:ft=sh
