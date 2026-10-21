# CachyOS Setup Guide

CachyOS come with native installer for multiple desktop environment.
Unfortunately, Umbriel is not supported yet, so we will proceed with no desktop environment and manually install the DE.

## Additional Packages

- Base-devel + Common packages, **disable**:
  - `fonts`
  - Some applications selection
    - `alacritty`
    - `glances`
    - `micro`
    - `nano`
    - `nano-syntax-highlighting`
- CachyOS Packages, **only select**:
  - `cachyos-kernel-manager`
  - `cachyos-settings`
- De-select all other packages

## Ansible

Roles are primarily divided into two types: `init` and `apps`.
- `init`: Includes applications that can be installed and set up in a headless environment.
- `apps`: Contains playbooks for any applications required to be installed after the initial setup (e.g., `spotify-launcher` and its dependency, `spicetify`).

### CachyOS Setup

1. Launch installer ISO, configure IPv4 DNS
1. Install CachyOS with no desktop
1. Setup SSH key and SSH config, then clone git repo
1. Install Ansible
    ```sh
    sudo pacman -S ansible
    ```
1. Run initialize playbook, provide `-e` flag to override target_username
    ```sh
    sudo ansible-playbook -i inventory.yaml init.yaml -e "target_username=someusername"
    ```
1. Reboot
1. Run application playbook
    ```sh
    sudo ansible-playbook -i inventory.yaml apps.yaml
    ```

## Manual Setup

### Umbriel & Noctalia

1. Launch installer ISO, configure IPv4 DNS
1. Install CachyOS with no desktop
1. Install `vim` and set default editor:
    ```sh
    sudo pacman -S vim
    export EDITOR=vim
    ```
1. Setup SSH key and SSH config, then clone git repo
1. Install `stow` and setup dotfiles
    ```sh
    sudo pacman -S stow
    cd personal/env-aesthetics/dotfiles
    stow -t $HOME/.config .
    ```
1. Install Noctalia Greeter
    ```sh
    sudo pacman -S greetd
    sudo systemctl enable greetd
    sudo pacman -Syu noctalia-greeter
    ```
1. Check where Noctalia Greeter in installed
    ```sh
    command -v noctalia-greeter-session
    ```
1. Configure `greetd` by adding below snippet to `/etc/greetd/config.toml`, also comment/remove the default `command`
    ```sh
    [default_session]
    command = "<noctalia-greeter-location>"
    user = "greeter"
    ```
1. Setup Noctalia Greeter:
    ```sh
    sudo systemd-tmpfiles --create noctalia-greeter.conf
    sudo noctalia-greeter-apply-appearance --setup-system
    sudo noctalia-greeter passwordless-sync enable <username>
    ```
1. Install required packages
    ```sh
    sudo pacman -S xwayland-satellite umbriel noctalia kitty
    ```

### LXQt Policy Setup

Application like CachyOS Hello need authentication agent, so installation and setup is needed

1. Install policy kit
    ```sh
    sudo pacman -S lxqt-policykit
    ```
1. Create systemd service by create file `~/.config/systemd/user/lxqt-policykit.service` with content:
    ```sh
    [Unit]
    Description=LXQt PolicyKit Authentication Agent
    After=graphical-session.target

    [Service]
    Type=simple
    ExecStart=/usr/bin/lxqt-policykit-agent
    Restart=on-failure
    RestartSec=3

    [Install]
    WantedBy=graphical-session.target
    ```
1. Start service
    ```sh
    systemctl --user enable --now lxqt-policykit.service
    ```

### Local DNS

1. Configure domain mapping
    ```sh
    sudoedit /etc/hosts
    ```
1. Add IP address and DNS hostname
    ```sh
    10.10.10.10  dns-hostname.local
    ```
1. Configure DNS on applications


