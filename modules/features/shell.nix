{ ... }:
let
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
  functions = ''
    nxs() {
      sudo nixos-rebuild switch --flake ".#$1"
    }
  '';
in
{

  flake.nixosModules.shell =
    { config, ... }:
    let
      secrets = config.sops.secrets;
    in
    {
      imports = [ common ];

      programs.bash = {
        enable = true;
        shellAliases = aliases;
        interactiveShellInit = ''
          [ -f "$HOME/.config/bash/init.sh" ] && source "$HOME/.config/bash/init.sh"

          if command -v starship &>/dev/null; then
            eval "$(starship init bash)"
          fi

          if command -v devenv &>/dev/null; then
            eval "$(devenv hook bash -- --no-reload --no-tui)"
          fi

          if command -v tmux &>/dev/null && [ -z "$TMUX" ]; then
            terminal="''${TERM#xterm-}"

            if ! tmux has-session -t "$terminal" 2>/dev/null; then
              tmux new-session -d -s "$terminal" \
                "sleep 0.5; fastfetch; exec bash"
            fi

            tmux attach-session -t "$terminal"
          fi

          export BOBSHELL_API_KEY="$(cat ${secrets."bash/bobshell_api_key".path})"
          export AI_BASE_URL="$(cat ${secrets."bash/ica_base_url".path})"
          export AI_API_KEY="$(cat ${secrets."bash/ica_base_key".path})"

          ${functions}
        '';
      };
    };

  flake.darwinModules.shell = { ... }: {
    imports = [ common ];

    programs.zsh = {
      enable = true;
      shellAliases = aliases;
    };
  };

}
