#!/bin/bash

NC='\033[0m'
CYAN='\033[0;36m'

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$DOTFILES_DIR/scripts/installers.sh"

mkdir -p "$HOME/.local/bin"
export PATH="$HOME/.local/bin:$PATH"

echo -e "${CYAN}--- Update & Upgrade Packages ---${NC}"

sudo apt update && sudo apt upgrade -y

echo -e "${CYAN}\n--- Starting Base Package Installation ---${NC}"

install_base

echo -e "${CYAN}\n--- Starting Package Installations ---${NC}"

install_binary "nvim" install_nvim

install_binary "starship" "curl -sS https://starship.rs/install.sh | sh -s -- -y"
install_binary "devbox" "curl -fsSL https://get.jetify.com/devbox | bash -s -- -y"
install_binary "opencode" "curl -fsSL https://opencode.ai/install | bash -s -- -y"

install_binary "docker" install_docker

echo -e "${CYAN}\n--- Setup Complete ---${NC}"
