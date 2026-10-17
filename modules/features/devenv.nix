{ ... }: {

  flake.nixosModules.devenv =
    {
      pkgs,
      config,
      lib,
      ...
    }:
    let
      cfg = config.my.devenv;

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
      options.my.devenv.nixpkgs = lib.mkOption {
        type = lib.types.raw;
        default = null;
        description = "Override devenv nixpkgs.";
      };

      config = {
        environment.systemPackages = [
          cfgPkgs.devenv
        ];
      };
    };

}
