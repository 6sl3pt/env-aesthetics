{ self, inputs, ... }: {

  flake.nixosModules.wslConfiguration = { ... }: {
    imports = [
      self.nixosModules.btop
      self.nixosModules.devenv
      self.nixosModules.doom-emacs-unstraightened
      self.nixosModules.dotfiles
      self.nixosModules.fonts
      self.nixosModules.git
      self.nixosModules.kitty
      self.nixosModules.nvim
      self.nixosModules.podman
      self.nixosModules.secrets
      self.nixosModules.shell
      self.nixosModules.spotify-pulseaudio
      self.nixosModules.ssh
      self.nixosModules.tmux
    ];

    my.dotfiles = {
      enable = true;
      user = "phudit";
      source = "/home/phudit/personal/env-aesthetics/dotfiles";
    };

    my.secrets = {
      user = "phudit";
      keyFile = "/home/phudit/.config/sops/age/nix-secrets.txt";
    };

    my.devenv = {
      nixpkgs = inputs.nixpkgs;
    };

    my.spotify = {
      nixpkgs = inputs.nixpkgs;
    };

  };

}
