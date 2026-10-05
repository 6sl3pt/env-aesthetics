{ ... }: {

  flake.nixosModules.nvim = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      fd
      fzf
      gcc
      ripgrep
      tree-sitter
    ];

    programs.neovim.enable = true;
  };

}
