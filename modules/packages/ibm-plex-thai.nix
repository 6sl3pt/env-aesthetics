{ ... }: {

  flake.overlays.ibm-plex-thai = final: prev: {
    ibm-plex-thai = final.stdenvNoCC.mkDerivation {
      pname = "ibm-plex-thai";
      version = "1.0.0";

      srcs = [
        (final.fetchurl {
          name = "IBMPlexSansThaiLooped-Regular.ttf";
          url = "https://fonts.gstatic.com/s/ibmplexsansthailooped/v12/tss_AoJJRAhL3BTrK3r2xxbFhvKfyBB6l7hHT30LxBI.ttf";
          hash = "sha256-KwT2WnXTwlM4Ozp/MH1DNlLf35WW0/K8IcwGhEzhyEs=";
        })
        (final.fetchurl {
          name = "IBMPlexSansThaiLooped-Bold.ttf";
          url = "https://fonts.gstatic.com/s/ibmplexsansthailooped/v12/tss6AoJJRAhL3BTrK3r2xxbFhvKfyBB6l7hHT30L_K6vhFk.ttf";
          hash = "sha256-YLLc/kl9j8H1QV3bi9TjRJ4MdyJX+vopapz+AsC9W9Y=";
        })
      ];

      dontUnpack = true;

      installPhase = ''
        runHook preInstall
        mkdir -p $out/share/fonts/truetype
        for f in $srcs; do
          fname=$(stripHash "$f")
          install -Dm644 "$f" "$out/share/fonts/truetype/$fname"
        done
        runHook postInstall
      '';
    };
  };

}
