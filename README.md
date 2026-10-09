# My Environment Settings & Aesthetic Themes

This repository is my personal collection of themes, settings, and configurations designed to bring a unified aesthetic across all the environments I use whether on Linux, Windows, or MacOS, and across various tools

The goal is simple: **achieve aesthetic consistency between every environment I work in**, and to do that I decided to use NixOS.
I don't care much about NixOS being perfectly pure. I like Nix for its ability to reproduce my environment across machines, even if I change hardware or OS.
I prefer usability over purity, so I keep configs as dotfiles [managed with Stow](/modules/features/dotfiles.nix) rather than `.nix` files that require rebuilding the OS for every small change.

NixOS focuses on setting up the environment, while dotfiles focus on usability and configuration.

## Content

```sh
env-aesthetics
├── background # cool backgrounds
├── dotfiles   # common application settings
├── modules    # Nix configuration for every machine
└── windows    # settings for Windows application
```

## Installation

### Pre-process

**WSL**

1. Install distro following [NixOS-WSL guide](https://nix-community.github.io/NixOS-WSL/install.html)

1. You will start with default `nixos` user, as a workaround create and work in new default user home directory instead:

    ```sh
    sudo mkdir -p /home/yourusername

    sudo chown -R nixos:users /home/yourusername
    ```

> If working in default nixos home directory, you will need to migrate or clone SSH and git repo to new user after setup.

### Setup

1. Setup SSH key
1. Temporary enable `git` and `openssh`

    ```sh
    nix-shell -p git openssh
    ```

1. Clone repository

    ```sh
    GIT_SSH_COMMAND='ssh -i ~/.ssh/id_ed25519_personal -o IdentitiesOnly=yes' \
      git clone git@github.com:6sl3pt/env-aesthetics.git
    ```

1. Build flake and switch to new build

    ```sh
    NIX_CONFIG="experimental-features = nix-command flakes" sudo nixos-rebuild switch --flake .#<host>
    ```

### Post-process

**WSL**

1. After switch successfully, terminate WSL:

    ```sh
    wsl --terminate NixOS
    ```

1. Start NixOS again, check user and package, then set password:

    ```sh
    whoami
    echo "$HOME"
    which git

    sudo passwd yourusername
    ```

1. Check `nixos` user, if not exists, delete `nixos` home directory:

    ```sh
    getent passwd nixos

    sudo rm -rf /home/nixos
    ```

## Application Notes

### Doom Emacs

Following the same principle above, **Doom Emacs is installed manually** rather than through Nix.
This keeps Doom's own workflow and lets me update it independently without rebuilding NixOS.

[Follow official install guideline](https://github.com/doomemacs/core#install)

### Kitty

**Theme Git Ignore Workaround:**

1. Create ignored directory with `kitty.conf` inside, for example `~/.config/kitty/ignored/`

1. Setup alias `alias kitty-theme=KITTY_CONFIG_DIRECTORY=<ignored-dir> kitty +kitten themes`

1. Inside main `kitty.conf`, add `include <ignored-dir>/kitty.conf`

1. On theme select, choose to modify (M)

1. This will change theme inside ignored directory, main config won't change

### Windows Shortcut

After apply [WSL NixOS](#nixos) configuration, create shortcut with location:

```
"C:\Program Files\WSL\wslg.exe" -d NixOS --cd "~" -- kitty

"C:\Program Files\WSL\wslg.exe" -d NixOS --cd "~" -- emacs
```

Make sure it's `wslg.exe` (Wayland) not `wsl.exe`
