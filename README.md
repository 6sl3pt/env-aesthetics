# My Environment Settings & Aesthetic Themes

This repository is my personal collection of themes, settings, and configurations designed to bring a unified aesthetic across all the environments I use whether on Linux, Windows, or MacOS, and across various tools

The goal is simple: **achieve aesthetic consistency between every environment I work in**, and to do that I decided to use NixOS.
I don't care much about NixOS being perfectly pure. I like Nix for its ability to reproduce my environment across machines, even if I change hardware or OS.
I prefer usability over purity, so I keep configs as dotfiles [managed with Stow](/modules/features/dotfiles.nix) rather than `.nix` files that require rebuilding the OS for every small change.

NixOS focuses on setting up the environment, while dotfiles focus on usability and configuration.

## Structure

```sh
env-aesthetics
├── background # cool backgrounds
├── dotfiles   # common application settings
├── modules    # Nix configuration for every machine
└── windows    # settings for Windows application
```

## Application Notes

Please **read the notes below before proceeding to installation**, as they may contain additional prerequisite or other information you should be aware of.

### SOPS AGE

After setup AGE key, secret file can be edit with command: `sops <secret-file>`

### Doom Emacs

Following the same principle above, [Doom Emacs is installed manually](https://github.com/doomemacs/core#install) rather than through Nix.
This keeps Doom's own workflow and lets me update it independently without rebuilding NixOS.

**WSL Limitation**

If you're using WSL and care about the annoying flow of opening a terminal,
typing a command to launch Doom Emacs, then closing it, unfortunately the pain continues.

As `emacs` binary will locked to `pkgs.emacs`, so you need to run `<doom-binary> emacs`.
That works from the terminal but not properly with Windows shortcuts.
Aliases don't help either, since shortcuts can't resolve bash aliases without invoking bash first.

### Niri

**WSL Limitation**

If you're using WSL, you MUST follow this [guide](https://gist.github.com/mle98/2deb6e0aa1da3aed70a73dad9c29e8f7)
to patch Microsoft's Weston mirror. Otherwise, you won't have a key bind to make Niri fullscreen.

As for the double-cursor issue, it seems to be somewhat random in my experience.
Sometimes I encounter it, and sometimes I don't.
To fix it, add the following snippet to `niri.nix` inside the `postPatch`:

```
substituteInPlace src/niri.rs \
  --replace-fail \
    'self.render_pointer(ctx.renderer, output, &mut |elem| push(elem.into()));' \
    '// self.render_pointer(ctx.renderer, output, &mut |elem| push(elem.into()));'
```

This will prevent Niri from rendering cursor, so that you can use Windows cursor on top of Niri.

### Noctalia

**WSL Limitation**

I only experiment with Noctalia on WSLg, and it can be considered broken, as many of its features don't work properly in this environment.

I mainly use it for automatic color schemes, nice background blur effects with Kitty, and integration with Niri.
If you just want a visually appealing shell, it might be fine, but **it's NOT fully functional** like Noctalia on regular Linux.

Bluetooth and WiFi don't work properly, and audio is also problematic.
There seem to be some instability in the PipeWire Pulse Tunnel and WSLg PulseAudio/RDP audio path.
Since Noctalia's built-in audio controls require PipeWire integration, getting audio to work reliably on WSLg is difficult.

I tried configuring PipeWire tunnel manually, but the audio is progressively degrade until playback becomes silent with `underflow` warning.
Running `systemctl --user restart pipewire pipewire-pulse wireplumber` temporarily restores sound, but the problem eventually returns.

### Kitty

**Theme Git Ignore Workaround:**

1. Create ignored directory with `kitty.conf` inside, for example `~/.config/kitty/themes/`

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

1. Migrate AGE key file
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
