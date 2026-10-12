{ self, inputs, ... }: {

  flake.nixosModules.wslConfiguration = { ... }: {
    imports = [
      inputs.nix-wsl.nixosModules.default
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

    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

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
    time.timeZone = "Asia/Bangkok";

    my.dotfiles = {
      enable = true;
      user = "phudit";
      source = "/home/phudit/personal/env-aesthetics/dotfiles";
    };

    my.secrets = {
      user = "phudit";
      keyFile = "/home/phudit/.config/sops/age/nix-secrets.txt";
    };
  };

}
