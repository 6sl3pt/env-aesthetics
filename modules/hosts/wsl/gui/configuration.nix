{ self, ... }: {

  flake.nixosModules.wslGuiConfiguration = { ... }: {
    imports = [
      self.nixosModules.dotfiles
      self.nixosModules.fonts
      self.nixosModules.git
      self.nixosModules.nvim
      self.nixosModules.secrets
      self.nixosModules.shell
      self.nixosModules.ssh
    ];
  };

}
