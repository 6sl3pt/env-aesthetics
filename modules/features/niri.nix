{ inputs, ... }: {

  flake.nixosModules.niri-wsl =
    { pkgs, ... }:
    let
      cfgPkgs = import inputs.nixpkgs {
        system = pkgs.stdenv.hostPlatform.system;
      };
    in
    {
      nixpkgs.overlays = [
        (final: prev: {
          niri = cfgPkgs.niri.overrideAttrs (old: {
            postPatch = (old.postPatch or "") + ''
              substituteInPlace src/backend/winit.rs \
                --replace-fail \
                  '.with_inner_size(LogicalSize::new(1280.0, 800.0))' \
                  '.with_inner_size(LogicalSize::new(1280.0, 800.0))
                    .with_decorations(false)'
            '';
          });
        })
      ];

      programs.niri = {
        enable = true;
        package = pkgs.niri;
      };
    };

}
