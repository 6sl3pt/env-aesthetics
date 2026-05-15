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

## Theme List
- Osaka Jade: inspired by beautiful [Osaka Jade](https://github.com/Justikun/omarchy-osaka-jade-theme) theme from [Omarchy](https://github.com/basecamp/omarchy)
