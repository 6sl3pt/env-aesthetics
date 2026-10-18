{ ... }:
let
  # common packages for every shell
  common = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      eza
      fastfetch
      starship
    ];
  };

  # nix-only aliases & functions
  aliases = {
    ls = "eza -lh --group-directories-first --icons=auto"; # force overwrite
    nxc = "nix-collect-garbage";
    nxo = "nix-store --optimise";
  };

  # options
  shellOptions = lib: {
    my.shell = {
      devenvInit.enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable devenv auto initialize hook.";
      };
      starshipInit.enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable starship auto initialize on shell open.";
      };
      tmuxInit.enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable tmux auto initialize on shell open.";
      };
    };
  };

  # rc configuration
  shellInit =
    lib: cfg: shell:
    lib.concatStrings [
      (lib.optionalString (cfg.starshipInit.enable) ''
        if command -v starship &>/dev/null; then
          eval "$(starship init ${shell})"
        fi
      '')

      (lib.optionalString (cfg.devenvInit.enable) ''
        if command -v devenv &>/dev/null; then
          eval "$(devenv hook ${shell} -- --no-reload --no-tui)"
        fi
      '')

      (lib.optionalString (cfg.tmuxInit.enable) ''
        if command -v tmux &>/dev/null && [ -z "$TMUX" ]; then
          terminal="''${TERM#xterm-}"

          if ! tmux has-session -t "$terminal" 2>/dev/null; then
            tmux new-session -d -s "$terminal" \
              "sleep 0.5; fastfetch; exec ${shell}"
          fi

          tmux attach-session -t "$terminal"
        fi
      '')
    ];
in
{

  flake.nixosModules.shell =
    { lib, config, ... }:
    let
      secrets = config.sops.secrets;
      cfg = config.my.shell;
    in
    {
      options = shellOptions lib;
      imports = [ common ];

      config = {
        programs.bash = {
          enable = true;
          shellAliases = aliases;
          interactiveShellInit = ''
            [ -f "$HOME/.config/bash/init.sh" ] && source "$HOME/.config/bash/init.sh"

            ${shellInit lib cfg "bash"}

            export BOBSHELL_API_KEY="$(cat ${secrets."bash/bobshell_api_key".path})"
            export AI_BASE_URL="$(cat ${secrets."bash/ica_base_url".path})"
            export AI_API_KEY="$(cat ${secrets."bash/ica_base_key".path})"

            nxs() {
              sudo nixos-rebuild switch --flake ".#$1"
            }
          '';
        };
      };
    };

  flake.darwinModules.shell =
    { lib, config, ... }:
    let
      cfg = config.my.shell;
    in
    {
      options = shellOptions lib;
      imports = [ common ];

      config = {
        programs.zsh = {
          enable = true;
          shellAliases = aliases;
          interactiveShellInit = ''
            ${shellInit lib cfg "zsh"}

            nxs() {
              sudo darwin-switch --flake ".#$1"
            }
          '';
        };
      };
    };

}
