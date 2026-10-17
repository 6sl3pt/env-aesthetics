{ ... }: {

  flake.nixosModules.spotify-pulseaudio =
    {
      pkgs,
      config,
      lib,
      ...
    }:
    let
      cfg = config.my.spotify;

      cfgPkgs =
        if cfg.nixpkgs != null then
          import cfg.nixpkgs {
            system = pkgs.stdenv.hostPlatform.system;
            config = config.nixpkgs.config;
          }
        else
          pkgs;
    in
    {
      options.my.spotify.nixpkgs = lib.mkOption {
        type = lib.types.raw;
        default = null;
        description = "Override spotify nixpkgs.";
      };

      config = {
        environment.systemPackages = [
          (cfgPkgs.spotify-player.override {
            withAudioBackend = "pulseaudio";
            withImage = true;
          })
        ];
      };
    };

}
