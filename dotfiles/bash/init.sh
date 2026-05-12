#!/bin/bash

__load_bash_config() {
  local conf_root="$HOME/.config/bash"
  local modules=("aliases" "variables" "functions")
  local module module_path file

  for module in "${modules[@]}"; do
    module_path="$conf_root/$module"

    if [ -d "$module_path" ]; then
      for file in "$module_path"/*; do
        if [ -r "$file" ] && [ -f "$file" ]; then
          source "$file"
        fi
      done
    fi
  done
}

__load_bash_config
unset -f __load_bash_config
