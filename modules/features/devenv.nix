{ inputs, ... }: {

  flake.nixosModules.devenv = { pkgs, ... }: {
    nixpkgs.overlays = [
      (final: prev: {
        devenv =
          (import inputs.pkgs-unstable {
            system = prev.stdenv.hostPlatform.system;
          }).devenv;
      })
    ];

    environment.systemPackages = with pkgs; [
      devenv
    ];
  };

}
