export EDITOR=vim

[ -f ~/.config/bash/init.sh ] && source ~/.config/bash/init.sh

if command -v starship &>/dev/null; then
  eval "$(starship init bash)"
fi
