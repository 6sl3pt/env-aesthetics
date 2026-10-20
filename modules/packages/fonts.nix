{ ... }: {

  perSystem =
    { pkgs, ... }:
    let
      fontPackages = {
        google-sans-flex = {
          fonts = [
            {
              name = "GoogleSansFlex.woff2";
              url = "https://fonts.gstatic.com/s/googlesansflex/v23/t5svIQcYNIWbFgDgAAzZ34auoVyXkJCOvp3SFWJbN5hF8Ju1x6sKCyp0l9sI40swNJwGpVd4AZzz0v6lJ4qFXNZhGjLvDSkV4W71Gn9C3w.woff2";
              hash = "sha256-Zp7sd5G16NGPA3XUSfb+hseeNdr3Bb65+mP2lowyH4g=";
            }
          ];
        };

        ibm-plex-thai = {
          fonts = [
            {
              name = "IBMPlexSansThai-Regular.woff2";
              url = "https://fonts.gstatic.com/s/ibmplexsansthai/v11/m8JPje1VVIzcq1HzJq2AEdo2Tj_qvLqMHdYgVcM.woff2";
              hash = "sha256-LWY4HCbTK/KpW/5VnRpe1Udfzaw/oSjkWjMwEBDUIFY=";
            }
            {
              name = "IBMPlexSansThai-Bold.woff2";
              url = "https://fonts.gstatic.com/s/ibmplexsansthai/v11/m8JMje1VVIzcq1HzJq2AEdo2Tj_qvLqEsvM1fuJHa74.woff2";
              hash = "sha256-CGLkTAB2HaFvkpoHjSxtXtMCue74SxQ7wcWhyKOjGHg=";
            }
          ];
        };

        ibm-plex-thai-looped = {
          fonts = [
            {
              name = "IBMPlexSansThaiLooped-Regular.ttf";
              url = "https://fonts.gstatic.com/s/ibmplexsansthailooped/v12/tss_AoJJRAhL3BTrK3r2xxbFhvKfyBB6l7hHT30LxBI.ttf";
              hash = "sha256-KwT2WnXTwlM4Ozp/MH1DNlLf35WW0/K8IcwGhEzhyEs=";
            }
            {
              name = "IBMPlexSansThaiLooped-Bold.ttf";
              url = "https://fonts.gstatic.com/s/ibmplexsansthailooped/v12/tss6AoJJRAhL3BTrK3r2xxbFhvKfyBB6l7hHT30L_K6vhFk.ttf";
              hash = "sha256-YLLc/kl9j8H1QV3bi9TjRJ4MdyJX+vopapz+AsC9W9Y=";
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
