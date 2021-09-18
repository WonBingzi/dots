#autoload -U colors && colors

source /usr/share/gitstatus/gitstatus.prompt.zsh

# This allows expansions
setopt PROMPT_SUBST

# Updates editor information when the keymap changes.
function zle-line-init zle-keymap-select() {
  zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

function vi_mode_prompt_info() {
  case $KEYMAP in
    vicmd) echo "NORMAL";;
    main|viins) echo "INSERT";;
    viopp) echo "OPERATOR";;
    visual) echo "VISUAL";;
  esac
}

# define right prompt, regardless of whether the theme defined it
RPS1='$(vi_mode_prompt_info)'
RPS2=$RPS1

# This part is for the virtualenv indicator
export VIRTUAL_ENV_DISABLE_PROMPT=yes

function virtenv_indicator {
    if [[ -z $VIRTUAL_ENV ]] then
        psvar[1]=''
    else
        psvar[1]="${VIRTUAL_ENV##*/}"
    fi
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd virtenv_indicator

# This needs to be in simple quotes
# https://unix.stackexchange.com/questions/32124/set-variables-in-zsh-precmd-and-reference-them-in-the-prompt

PROMPT='%B'
PROMPT+='%F{black}%(?:%K{green} ✓%F{green}%K{yellow}:%K{red} ✕%F{red}%K{yellow})'
PROMPT+='%F{black}%n'
PROMPT+='%F{yellow}%K{blue}'
PROMPT+='%F{black}%m'
PROMPT+='%F{blue}%K{magenta}'
PROMPT+='%F{black}%K{magenta}%2.'
PROMPT+='$(git rev-parse --is-inside-work-tree &>/dev/null && echo "  ")'
PROMPT+='$GITSTATUS_PROMPT'
PROMPT+='%F{magenta}'
PROMPT+='%k%b%f '
