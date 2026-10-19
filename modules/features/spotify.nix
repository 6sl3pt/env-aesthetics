{ inputs, ... }: {

  flake.nixosModules.spotify-player =
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
      options.my.spotify = {
        nixpkgs = lib.mkOption {
          type = lib.types.raw;
          default = null;
          description = "Override spotify nixpkgs.";
        };
        backend = lib.mkOption {
          type = lib.types.enum [
            "rodio"
            "alsa"
            "pulseaudio"
            "portaudio"
            "jackaudio"
            "rodiojack"
            "sdl"
            "gstreamer"
          ];
          default = "rodio";
          description = "spotify_player audio backend";
        };
      };

      config = {
        environment.systemPackages = [
          (cfgPkgs.spotify-player.override {
            withAudioBackend = cfg.backend;
            withImage = true;
          })
        ];
      };
    };

  flake.nixosModules.spicetify =
    { pkgs, lib, ... }:
    {
      nixpkgs.config.allowUnfreePredicate =
        pkg:
        builtins.elem (lib.getName pkg) [
          "spotify"
        ];

      imports = [
        inputs.spicetify.nixosModules.default
      ];

      programs.spicetify =
        let
          spicePkgs = inputs.spicetify.legacyPackages.${pkgs.stdenv.hostPlatform.system};
        in
        {
          enable = true;
          enabledExtensions = with spicePkgs.extensions; [
            adblockify
            hidePodcasts
            shuffle
          ];
          theme = spicePkgs.themes.comfy;
          colorScheme = "Comfy";
        };
    };

}
