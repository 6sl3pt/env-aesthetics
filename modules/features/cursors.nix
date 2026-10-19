{ ... }: {

  flake.nixosModules.cursors = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      bibata-cursors
    ];
  };

}
