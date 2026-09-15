# My Environment Settings & Aesthetic Themes

This repository is my personal collection of themes, settings, and configurations designed to bring a unified aesthetic across all the environments I use whether on Linux, Windows, or MacOS, and across various tools

The goal is simple: **achieve aesthetic consistency between every environment I work in**

## Content

- `/background`: cool backgrounds
- `/dotfiles`: common application settings
- `/macos`: settings for MacOS application
- `/windows`: settings for Windows application

## Installation

### Spotify Player

1. Install [Rust and cargo](https://www.rust-lang.org/tools/install) as the build dependencies

1. Install [application dependencies](https://github.com/aome510/spotify-player/blob/master/README.md#installation)

#### WSL2

Since WSL2 come with WSLg which contains pulse audio, install `pulseaudio-backend` instead of default `rodio-backend`

```sh
# check if pulse audio server existed
echo $PULSE_SERVER

# install with features
cargo install spotify_player --no-default-features \
  --features pulseaudio-backend,image
```

### Kitty

**Theme Git Ignore Workaround:**

1. Create ignored directory with `kitty.conf` inside, for example `~/.config/kitty/ignored/`

1. Setup alias `alias kitty-theme=KITTY_CONFIG_DIRECTORY=<ignored-dir> kitty +kitten themes`

1. Inside main `kitty.conf`, add `include <ignored-dir>/kitty.conf`

1. On theme select, choose to modify (M)

1. This will change theme inside ignored directory, main config won't change

#### WSL2

1. Install latest mesa

```sh
sudo add-apt-repository ppa:kisak/kisak-mesa

sudo apt upgrade
```

1. (Optional) Install `mesa-utils` to check if your WSL can run kitty or not (kitty required OpenGL 3+)

```sh
sudo apt install mesa-utils

glxinfo -B
```

1. Install Kitty: `sudo apt install kitty`, start it with `kitty`

1. At this point, shortcut should be create at `~\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\<distro>` which will automatically open kitty terminal on top of WSL

### Doom Emacs

1. Install Emacs: `sudo apt install emacs`

1. Install Doom Emacs by following official [guide](https://github.com/doomemacs/core)
