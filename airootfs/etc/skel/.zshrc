#!/usr/bin/zsh

ZSH=/usr/share/oh-my-zsh/

# ZSH_THEME="robbyrussell"
# ZSH_THEME="oxide"
# ZSH_THEME="refined"
ZSH_THEME="af-magic"
DISABLE_AUTO_UPDATE="true"
plugins=(
)
export PATH=$HOME/.bin:$HOME/.bin/popup:$HOME/.local/bin:/usr/local/bin:$PATH
ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
[[ ! -d $ZSH_CACHE_DIR ]] && mkdir -p $ZSH_CACHE_DIR
source $ZSH/oh-my-zsh.sh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=white"

export EDITOR="$(if [[ -n $DISPLAY ]]; then echo 'mousepad'; else echo 'nano'; fi)"
export BROWSER="firefox"
export SSH_KEY_PATH="~/.ssh/dsa_id"

if [ -f ~/.alias_zsh ]; then
  . ~/.alias_zsh
fi
