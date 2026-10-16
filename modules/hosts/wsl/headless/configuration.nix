{ self, ... }: {

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
  };

}
