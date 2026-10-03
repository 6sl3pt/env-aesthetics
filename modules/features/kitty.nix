{ pkgs, ... }: {

  flake.nixosModules.kitty = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      kitty
    ];
  };

}
