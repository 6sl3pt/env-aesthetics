{ inputs, ... }: {

  flake.nixosModules.spotify-pulseaudio = { pkgs, ... }: {
    nixpkgs.overlays = [
      (final: prev: {
        spotify-player =
          (import inputs.pkgs-unstable {
            system = prev.stdenv.hostPlatform.system;
          }).spotify-player;
      })
    ];

    environment.systemPackages = [
      (pkgs.spotify-player.override {
        withAudioBackend = "pulseaudio";
        withImage = true;
      })
    ];
  };

}
