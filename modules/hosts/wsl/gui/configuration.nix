{ self, inputs, ... }: {

  flake.nixosModules.wslGuiConfiguration = { ... }: {
    imports = [
      self.nixosModules.btop
      self.nixosModules.devenv
      self.nixosModules.dotfiles
      self.nixosModules.emacs
      self.nixosModules.fonts
      self.nixosModules.git
      self.nixosModules.kitty
      self.nixosModules.niri
      self.nixosModules.noctalia
      self.nixosModules.nvim
      self.nixosModules.podman
      self.nixosModules.secrets
      self.nixosModules.shell
      self.nixosModules.spotify-player
      self.nixosModules.ssh
      self.nixosModules.tmux
      self.nixosModules.zen-browser
    ];

    services = {
      power-profiles-daemon.enable = true;
      upower.enable = true;
    };

    my.devenv = {
      nixpkgs = inputs.nixpkgs;
    };

    my.dotfiles = {
      enable = true;
      user = "phudit";
      source = "/home/phudit/personal/env-aesthetics/dotfiles";
    };

    my.niri = {
      nixpkgs = inputs.nixpkgs;
      decorations.enable = false;
    };

    my.noctalia = {
      recommendedServices.enable = false;
    };

    my.secrets = {
      user = "phudit";
      keyFile = "/home/phudit/.config/sops/age/nix-secrets.txt";
    };

    my.shell = {
      tmuxInit.enable = false;
    };

    my.spotify = {
      nixpkgs = inputs.nixpkgs;
      backend = "pulseaudio";
    };
  };

}
