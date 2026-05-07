#!/bin/bash

# git - convert -f to --force-with-lease
function git() {
  if [[ "$1" == "push" ]]; then
    args=()
    replaced=false

    for arg in "${@:2}"; do
      case "$arg" in
      -f | --force)
        args+=("--force-with-lease")
        replaced=true
        ;;
      *)
        args+=("$arg")
        ;;
      esac
    done

    if [ "$replaced" = true ]; then
      echo -e "\e[1;33mConverting force push to --force-with-lease\e[0m" >&2
    fi

    command git push "${args[@]}"
  else
    command git "$@"
  fi
}
