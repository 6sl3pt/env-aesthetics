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
      interactiveShellInit = ''
        unalias ls 2>/dev/null

        [ -f "$HOME/.config/bash/init.sh" ] && source "$HOME/.config/bash/init.sh"

        if command -v starship &>/dev/null; then
          eval "$(starship init bash)"
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
