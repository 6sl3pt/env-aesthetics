{ inputs, ... }: {

  flake.nixosModules.emacs = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      emacs
      fd
      git
      ripgrep
    ];
  };

  flake.nixosModules.doom-emacs-unstraightened = { pkgs, ... }: {
    nixpkgs.overlays = [
      inputs.nix-doom-emacs-unstraightened.overlays.default
    ];

    environment.systemPackages = with pkgs; [
      fd
      git
      ripgrep
      (emacsWithDoom {
        emacs = emacs-pgtk;
        doomDir = ../../dotfiles/doom;
        doomLocalDir = "~/.local/share/doom";
      })
    ];
  };

}
