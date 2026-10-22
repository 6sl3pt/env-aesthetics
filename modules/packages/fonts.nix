{ ... }: {

  perSystem =
    { pkgs, ... }:
    let
      fontPackages = {
        google-sans-flex = {
          fonts = [
            {
              name = "GoogleSansFlex.tff";
              url = "https://raw.githubusercontent.com/google/fonts/main/ofl/googlesansflex/GoogleSansFlex%5BROND%2Copsz%2Cslnt%2Cwdth%2Cwght%5D.ttf";
              hash = "sha256-qax3B5iFfV6KxZPO1Csi5Ap8CM7Jgxn5Kw7Mwng6d7o=";
            }
          ];
        };

        ibm-plex-thai = {
          fonts = [
            {
              name = "IBMPlexSansThai-Regular.tff";
              url = "https://raw.githubusercontent.com/google/fonts/main/ofl/ibmplexsansthai/IBMPlexSansThai-Regular.ttf";
              hash = "sha256-7uBh0brDm+QPm7lEmImM0YlPXT2aLw7my9SKa9A9BSs=";
            }
            {
              name = "IBMPlexSansThai-Bold.tff";
              url = "https://raw.githubusercontent.com/google/fonts/main/ofl/ibmplexsansthai/IBMPlexSansThai-Bold.ttf";
              hash = "sha256-+I++CjcXyT3t30sT5QoFya3NOPWNZ12dXQuGmWGFFmc=";
            }
          ];
        };

        ibm-plex-thai-looped = {
          fonts = [
            {
              name = "IBMPlexSansThaiLooped-Regular.ttf";
              url = "https://raw.githubusercontent.com/google/fonts/main/ofl/ibmplexsansthailooped/IBMPlexSansThaiLooped-Regular.ttf";
              hash = "sha256-bXkQ0Tp6njOHLVUB/YGnH4TuUy9ym/tyxv+pTR8TAJ4=";
            }
            {
              name = "IBMPlexSansThaiLooped-Bold.ttf";
              url = "https://raw.githubusercontent.com/google/fonts/main/ofl/ibmplexsansthailooped/IBMPlexSansThaiLooped-Bold.ttf";
              hash = "sha256-31PFx5S5EPaLuPMHWmyb9ZJhw62WS9K+Dd/xvUx5x6k=";
            }
          ];
        };
      };

      mkFontPackage =
        pname:
        { fonts }:
        pkgs.stdenvNoCC.mkDerivation {
          inherit pname;
          version = "1.0.0";

          srcs = map (
            font:
            pkgs.fetchurl {
              inherit (font) url hash;
              name = font.name;
            }
          ) fonts;

          dontUnpack = true;

          installPhase = ''
            runHook preInstall
            mkdir -p "$out/share/fonts/truetype"

            for f in $srcs; do
              fname=$(stripHash "$f")
              install -Dm644 "$f" "$out/share/fonts/truetype/$fname"
            done

            runHook postInstall
          '';
        };
    in
    {
      packages = builtins.mapAttrs mkFontPackage fontPackages;
    };

}
