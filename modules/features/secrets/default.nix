{ inputs, ... }: {

  flake.nixosModules.secrets =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      cfg = config.my.secrets;
    in
    {
      imports = [
        inputs.sops-nix.nixosModules.default
      ];

      options.my.secrets = {
        user = lib.mkOption {
          type = lib.types.str;
          description = "User whose own secrets.";
        };

        keyFile = lib.mkOption {
          type = lib.types.path;
          description = "SOPS AGE key file location.";
        };
      };

      config = {
        environment.systemPackages = with pkgs; [
          age
          sops
        ];

        sops = {
          defaultSopsFile = ./secrets.yaml;
          defaultSopsFormat = "yaml";
          age.keyFile = cfg.keyFile;

          secrets."bash/bobshell_api_key".owner = cfg.user;
          secrets."bash/ica_base_url".owner = cfg.user;
          secrets."bash/ica_base_key".owner = cfg.user;
        };
      };
    };

}
