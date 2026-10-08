{ ... }: {

  flake.nixosModules.tmux = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      btop
      fzf
    ];

    programs.tmux.enable = true;
  };

}
