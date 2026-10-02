{ ... }: {

  flake.nixosModules.dotfiles = { config, lib, pkgs, ... }: 
  let
    cfg = config.my.dotfiles;
  in
  {
    options.my.dotfiles = {
      enable = lib.mkEnableOption "dotfiles managed by stow";

      user = lib.mkOption {
        type = lib.types.str;
        description = "User whose dotfiles are managed.";
      };

      source = lib.mkOption {
        type = lib.types.path;
        description = "Directory containing stow packages.";
      };
    };

    config = lib.mkIf cfg.enable {
      environment.systemPackages = with pkgs; [
        stow
      ];

      system.activationScripts.dotfiles.text = ''
        install -d -o ${cfg.user} -g users \
          /home/${cfg.user}/.config

        cd ${lib.escapeShellArg cfg.source}

        runuser -u ${cfg.user} -- \
          ${pkgs.stow}/bin/stow \
            --target /home/${cfg.user}/.config \
            .
      '';
    };
  };

}

