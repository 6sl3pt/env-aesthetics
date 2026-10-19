{ inputs, ... }: {

  flake.nixosModules.zen-browser =
    { pkgs, lib, ... }:
    let
      extension = shortId: guid: {
        name = guid;
        value = {
          install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
          installation_mode = "normal_installed";
          private_browsing = true;
        };
      };

      prefs = {
        # ── Zen-specific ──
        "zen.widget.linux.transparency" = true;
        "zen.workspaces.continue-where-left-off" = true;
        "zen.welcome-screen.seen" = true;

        # ── Privacy & security ──
        "beacon.enabled" = false;
        "browser.contentblocking.category" = "strict";
        "browser.dataFeatureRecommendations.enabled" = false;
        "browser.discovery.enabled" = false;
        "browser.send_pings" = false;
        "browser.formfill.enable" = false;
        "browser.region.update.enabled" = false;
        "dom.battery.enabled" = false;
        "dom.security.sanitizer.enabled" = true;
        "privacy.clearOnShutdown_v2.browsingHistoryAndDownloads" = true;
        "privacy.clearOnShutdown_v2.cache" = true;
        "privacy.clearOnShutdown_v2.cookiesAndStorage" = false;
        "privacy.clearOnShutdown_v2.formdata" = true;
        "privacy.globalprivacycontrol.enabled" = true;
        "privacy.query_stripping.enabled" = true;
        "privacy.query_stripping.enabled.pbmode" = true;
        "privacy.sanitize.sanitizeOnShutdown" = true;
        "privacy.trackingprotection.emailtracking.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
        "signon.autofillForms" = false;
        "signon.generation.enabled" = false;
        "signon.rememberSignons" = false;
        "security.OCSP.enabled" = 1;
        "security.OCSP.require" = true;
        "security.pki.crlite_mode" = 2;
        "security.remote_settings.crlite_filters.enabled" = true;
        "security.ssl.enable_ocsp_must_staple" = true;
        "security.ssl.enable_ocsp_stapling" = true;
        "security.ssl.require_safe_negotiation" = true;

        # ── Theme & UI ──
        "browser.aboutConfig.showWarning" = false;
        "zen.view.use-single-toolbar" = false;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "widget.wayland.opaque-region.enabled" = false;
        "browser.tabs.warnOnClose" = false;
        "browser.urlbar.suggest.topsites" = false;
        "browser.translations.automaticallyPopup" = false;

        # ── Extensions ──
        "extensions.getAddons.showPane" = false;
        "extensions.htmlaboutaddons.discover.enabled" = false;
        "extensions.htmlaboutaddons.recommendations.enabled" = false;
        "extensions.pocket.enabled" = false;
        "extensions.webcompat-reporter.enabled" = false;

        # ── DevTools ──
        "devtools.chrome.enabled" = true;
        "devtools.toolbox.host" = "right";
      };

      extensions = [
        (extension "ublock-origin" "uBlock0@raymondhill.net")
      ];
    in
    {
      environment.systemPackages = [
        (pkgs.wrapFirefox
          inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.zen-browser-unwrapped
          {
            extraPrefs = lib.concatLines (
              lib.mapAttrsToList (
                name: value: "lockPref(${lib.strings.toJSON name}, ${lib.strings.toJSON value});"
              ) prefs
            );

            extraPolicies = {
              DisableTelemetry = true;
              ExtensionSettings = builtins.listToAttrs extensions;

              SearchEngines = {
                Default = "g";
                Add = [
                  {
                    Name = "nixpkgs packages";
                    URLTemplate = "https://search.nixos.org/packages?query={searchTerms}";
                    IconURL = "https://wiki.nixos.org/favicon.ico";
                    Alias = "@np";
                  }
                  {
                    Name = "NixOS options";
                    URLTemplate = "https://search.nixos.org/options?query={searchTerms}";
                    IconURL = "https://wiki.nixos.org/favicon.ico";
                    Alias = "@no";
                  }
                  {
                    Name = "NixOS Wiki";
                    URLTemplate = "https://wiki.nixos.org/w/index.php?search={searchTerms}";
                    IconURL = "https://wiki.nixos.org/favicon.ico";
                    Alias = "@nw";
                  }
                  {
                    Name = "noogle";
                    URLTemplate = "https://noogle.dev/q?term={searchTerms}";
                    IconURL = "https://noogle.dev/favicon.ico";
                    Alias = "@ng";
                  }
                ];
              };
            };
          }
        )
      ];
    };

}
