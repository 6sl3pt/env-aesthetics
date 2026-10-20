{ ... }: {

  flake.nixosModules.pcmanfm-qt =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    let
      cfg = config.my.pcmanfm;
    in
    {
      options.my.pcmanfm.user = lib.mkOption {
        type = lib.types.str;
        description = "User for dynamic icon handling logic.";
      };

      config = {
        environment.systemPackages = with pkgs; [
          pcmanfm-qt
          lxmenu-data
          shared-mime-info

          qt6Packages.qt6ct
        ];

        qt = {
          enable = true;
          platformTheme = "qt5ct";
        };

        environment.etc."xdg/pcmanfm-qt/settings.conf" = {
          text = ''
            [Desktop]
            Font="CaskaydiaMono Nerd Font,9,-1,5,400,0,0,0,0,0,0,0,0,0,0,1,,0,0"

            [System]
            Terminal=kitty

            [Window]
            AlwaysShowTabs=false
            RememberWindowSize=false
            ReopenLastTabs=false
            ShowMenuBar=false
            ShowTabClose=false
          '';
          mode = "0644";
        };

        system.activationScripts.setupNoctaliaColloid = {
          text = ''
            ${pkgs.util-linux}/bin/runuser -u ${cfg.user} -- ${pkgs.bash}/bin/bash << 'EOF'
              export PATH='${pkgs.gtk3}/bin:${pkgs.gnused}/bin:${pkgs.coreutils}/bin:${pkgs.git}/bin:$PATH'

              THEME_NAME="Noctalia-Colloid"
              THEME_TMP="Noctalia-Colloid-tmp"
              ICON_DIR="/home/${cfg.user}/.local/share/icons"
              THEME_DIR="/home/${cfg.user}/.local/share/icons/Noctalia-Colloid"
              TMP_DIR="/home/${cfg.user}/.cache/noctalia/colloid-icon-themes"

              if [ -d "$THEME_DIR/.git" ]; then
                exit 0
              fi

              mkdir -p "$(dirname "$TMP_DIR")" "$ICON_DIR"
              chown -R ${cfg.user}:users "$(dirname "$TMP_DIR")" "$ICON_DIR"

              if [ ! -d "$TMP_DIR/.git" ]; then
                rm -rf "$TMP_DIR"
                git clone --depth 1 https://github.com/vinceliuice/Colloid-icon-theme.git "$TMP_DIR"
              else
                cd "$TMP_DIR" && git pull -q --rebase || true
              fi

              ${pkgs.bash}/bin/bash "$TMP_DIR/install.sh" -d "$ICON_DIR" -n "$THEME_NAME" -t default -s default

              cp -rL "$ICON_DIR/$THEME_NAME" "$ICON_DIR/$THEME_TMP" 2>/dev/null || true
              rm -rf "$ICON_DIR/$THEME_NAME"
              mv "$ICON_DIR/$THEME_TMP" "$ICON_DIR/$THEME_NAME"

              rm -rf "$ICON_DIR/Noctalia-Colloid-Dark" "$ICON_DIR/Noctalia-Colloid-Light"
              rm -rf "$ICON_DIR/Noctalia-Colloid-dark" "$ICON_DIR/Noctalia-Colloid-light"

              if [ -d "$THEME_DIR" ]; then
                cd "$THEME_DIR"
                rm -rf .git
                git init -q

                git config user.name 'Noctalia Automator'
                git config user.email 'noctalia@local.invalid'

                git add .
                git commit --no-verify -q -m 'original'
                git tag -f 'original'

                gtk-update-icon-cache -f -t "$THEME_DIR"
              else
                echo "Error: Theme directory $THEME_DIR was not created by install.sh" >&2
                exit 1
              fi
            EOF
          '';
        };
      };
    };

}
