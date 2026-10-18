{ ... }: {

  flake.nixosModules.niri =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    let
      cfg = config.my.niri;

      cfgPkgs =
        if cfg.nixpkgs != null then
          import cfg.nixpkgs {
            system = pkgs.stdenv.hostPlatform.system;
            config = config.nixpkgs.config;
          }
        else
          pkgs;

      cfgPatches = lib.concatStrings [
        (lib.optionalString (!cfg.cursor.enable) ''
          substituteInPlace src/niri.rs \
            --replace-fail \
              'self.render_pointer(ctx.renderer, output, &mut |elem| push(elem.into()));' \
              '// self.render_pointer(ctx.renderer, output, &mut |elem| push(elem.into()));'
        '')

        (lib.optionalString (!cfg.decorations.enable) ''
          substituteInPlace src/backend/winit.rs \
            --replace-fail \
              '.with_inner_size(LogicalSize::new(1280.0, 800.0))' \
              '.with_inner_size(LogicalSize::new(1280.0, 800.0))
                .with_decorations(false)'
        '')
      ];
    in
    {
      options.my.niri = {
        nixpkgs = lib.mkOption {
          type = lib.types.raw;
          default = null;
          description = "Override devenv nixpkgs.";
        };
        cursor.enable = lib.mkOption {
          type = lib.types.bool;
          default = true;
          description = "Enable cursor rendering on Niri.";
        };
        decorations.enable = lib.mkOption {
          type = lib.types.bool;
          default = true;
          description = "Enable Niri decoration.";
        };
      };

      config = {
        nixpkgs.overlays = [
          (final: prev: {
            niri = cfgPkgs.niri.overrideAttrs (old: {
              postPatch = (old.postPatch or "") + cfgPatches;
            });
          })
        ];

        programs.niri = {
          enable = true;
          package = pkgs.niri;
        };
      };
    };

}
