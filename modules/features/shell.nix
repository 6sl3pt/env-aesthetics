{ pkgs, ... }:
let
  common = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      eza
      fastfetch
      starship
    ];
  };
in
{

  flake.nixosModules.shell = { pkgs, ... }: {
    imports = [ common ];

    programs.bash = {
      enable = true;
      shellAliases = {
        ls = "eza -lh --group-directories-first --icons=auto";
      };
      interactiveShellInit = ''
        [ -f "$HOME/.config/bash/init.sh" ] && source "$HOME/.config/bash/init.sh"

        if command -v starship &>/dev/null; then
          eval "$(starship init bash)"
        fi

        if command -v tmux &>/dev/null && [ -z "$TMUX" ]; then
          terminal="''${TERM#xterm-}"

          if ! tmux has-session -t "$terminal" 2>/dev/null; then
            tmux new-session -d -s "$terminal" \
              "sleep 0.5; fastfetch; exec bash"
          fi

          tmux attach-session -t "$terminal"
        fi
      '';
    };
  };

  flake.darwinModules.shell = { pkgs, ... }: {
    imports = [ common ];

    programs.zsh = {
      enable = true;
    };
  };

}
