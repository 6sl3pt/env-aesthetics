#!/usr/bin/env bash

TMUX_DIR="$HOME/.config/tmux"
CURRENT_THEME="$TMUX_DIR/current-theme.conf"
DEFAULT_THEME="gruvbox-material-dark-soft"

if [[ ! -f "$CURRENT_THEME" ]]; then
  cp "$TMUX_DIR/themes/$DEFAULT_THEME.conf" "$CURRENT_THEME"
fi

while IFS='=' read -r key value; do
  [[ -z "$key" || "$key" == \#* ]] && continue
  tmux set-option -gq "@${key}" "${value//\"/}"
done <"$CURRENT_THEME"
