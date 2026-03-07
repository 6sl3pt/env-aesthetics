#!/bin/bash

echo "--- Starting Base Installation ---"

MISSING_PKGS=$(dpkg -l $(cat base.packages) 2>&1 | grep "no packages found" | awk '{print $6}')

if [ -n "$MISSING_PKGS" ]; then
  echo "Installing missing: $MISSING_PKGS"
  sudo apt update && sudo apt install -y $(cat base.packages)
else
  echo "System is already up to date!"
fi

echo -e "\n--- Optional Curl Installations ---"

if [ -f "curl.packages" ]; then
  while read -r name url; do
    [[ -z "$name" || "$name" =~ ^# ]] && continue

    if command -v "$name" &>/dev/null; then
      echo -e "[\033[1;34mSKIP\033[0m] $name is already installed."
      continue
    fi

    echo -e "\nPackage: \033[1;32m$name\033[0m"
    echo "Source: $url"

    read -p "Would you like to install $name? (y/N): " choice

    if [[ "$choice" =~ ^[Yy]$ ]]; then
      echo "Installing $name..."
      curl -fsSL "$url" | sh
    else
      echo "Skipping $name."
    fi
  done <"curl.packages"
else
  echo "curl.packages not found."
fi

echo -e "\nSetup complete!"
