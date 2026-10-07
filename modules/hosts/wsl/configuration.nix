{ self, inputs, ... }: {

  flake.nixosModules.wslConfiguration = { pkgs, ... }: {
    imports = [
      inputs.nix-wsl.nixosModules.default
      self.nixosModules.btop
      self.nixosModules.dotfiles
      self.nixosModules.emacs
      self.nixosModules.fonts
      self.nixosModules.git
      self.nixosModules.kitty
      self.nixosModules.nvim
      self.nixosModules.podman
      self.nixosModules.shell
      self.nixosModules.spotify-pulseaudio
      self.nixosModules.ssh
      self.nixosModules.tmux
    ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    wsl.enable = true;
    wsl.defaultUser = "phudit";

    users.users.phudit = {
      isNormalUser = true;
      description = "Phudit";
      extraGroups = [
        "wheel"
      ];
    };

    system.stateVersion = "26.05";

    my.dotfiles = {
      enable = true;
      user = "phudit";
      source = "/home/phudit/personal/env-aesthetics/dotfiles";
    };
  };

}
