#!/usr/bin/env bash

TMUX_DIR="$HOME/.config/tmux"
THEME_DIR="$TMUX_DIR/themes"
CURRENT_THEME="$TMUX_DIR/current-theme.conf"
TMUX_CONF="$TMUX_DIR/tmux.conf"

declare -A colors
if [[ -f "$CURRENT_THEME" ]]; then
  while IFS='=' read -r key val; do
    [[ -z "$key" || "$key" =~ ^# ]] && continue
    colors["$key"]="${val//\"/}"
  done <"$CURRENT_THEME"
fi

preview_cmd='
  conf="'"$THEME_DIR"'"/{}.conf
  if [[ -f "$conf" ]]; then
    while IFS="=" read -r key val; do
      [[ -z "$key" || "$key" =~ ^# ]] && continue
      val="${val//\"/}"
      val="${val//\#/}"
      r=$((16#${val:0:2}))
      g=$((16#${val:2:2}))
      b=$((16#${val:4:2}))
      printf "\033[48;2;%d;%d;%dm    \033[0m %-20s #%s\n" "$r" "$g" "$b" "$key" "$val"
    done < "$conf"
  fi
'

theme=$(
  find "$THEME_DIR" -maxdepth 1 -type f -name '*.conf' -printf '%f\n' |
    sed 's/\.conf$//' |
    sort |
    fzf \
      --prompt=" " \
      --pointer="" \
      --height=100% \
      --layout=reverse \
      --style=full:rounded \
      --highlight-line \
      --input-label=" Tmux Themes " \
      --preview-window=right:50%:border-rounded \
      --preview-label=" Preview " \
      --color="bg:${colors[thm_bg]},fg:${colors[thm_fg]}" \
      --color="bg+:${colors[thm_bright_black]},fg+:${colors[thm_fg]}" \
      --color="hl:${colors[thm_green]},hl+:${colors[thm_green]}" \
      --color="prompt:${colors[thm_orange]},spinner:${colors[thm_magenta]}" \
      --color="border:${colors[thm_border]},label:${colors[thm_orange]}" \
      --preview="$preview_cmd"
)

[[ -z "$theme" ]] && exit 0

theme_file="$THEME_DIR/$theme.conf"

cp "$theme_file" "$CURRENT_THEME"

while IFS='=' read -r key value; do
  [[ -z "$key" || "$key" == \#* ]] && continue
  tmux set-option -gq "@${key}" "${value//\"/}"
done <"$CURRENT_THEME"

tmux source-file "$TMUX_CONF"
