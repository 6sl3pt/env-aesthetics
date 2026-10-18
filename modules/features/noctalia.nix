{ inputs, ... }: {

  flake.nixosModules.noctalia =
    { config, lib, ... }:
    let
      cfg = config.my.noctalia;
    in
    {
      options.my.noctalia.recommendedServices.enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Use Noctalia recommended services.";
      };

      imports = [
        inputs.noctalia.nixosModules.default
      ];

      config = {
        programs.noctalia = {
          enable = true;
          recommendedServices.enable = cfg.recommendedServices.enable;
        };
      };
    };

}
