#!/bin/bash

NC='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
MAGENTA='\033[0;35m'

install_base() {
  DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  MISSING_PKGS=$(dpkg -l $(cat "${DOTFILES_DIR}/base.packages") 2>&1 | grep "no packages found" | awk '{print $6}')

  if [ -n "$MISSING_PKGS" ]; then
    echo "Installing missing: $MISSING_PKGS"
    sudo apt install -y $(cat base.packages)
  else
    echo -e "${GREEN}✓ All base packages is already installed${NC}"
  fi
}

install_binary() {
  local name=$1
  shift

  if command -v "$name" >/dev/null 2>&1; then
    echo -e "${GREEN}✓ $name is already installed${NC}"
  else
    echo "Installing $name..."
    "$@"

    if command -v "$name" >/dev/null 2>&1; then
      echo -e "${GREEN}  ✓ $name successfully installed${NC}"
    else
      echo -e "${RED}  ✘ Error: $name installation failed${NC}"
    fi
  fi
}

install_nvim() {
  curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz

  sudo rm -rf /opt/nvim-linux-x86_64

  sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz

  export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
}

install_docker() {
  curl -fsSL https://get.docker.com -o get-docker.sh

  sudo sh get-docker.sh

  sudo usermod -aG docker "$USER"

  rm get-docker.sh

  echo -e "${MAGENTA}  !] Remember to log out and back in for group changes to take effect.${NC}"
}
