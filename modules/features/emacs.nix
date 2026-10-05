{ ... }: {

  flake.nixosModules.emacs = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      emacs
      fd
      git
      ripgrep
    ];
  };

}
