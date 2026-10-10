{ ... }: {

  flake.nixosModules.nvim = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      # LSPs
      lua-language-server
      nixd
      nixfmt

      # mason dependencies
      nodejs
      unzip

      # tools
      fd
      fzf
      gcc
      ripgrep
      tree-sitter
    ];

    programs.neovim = {
      enable = true;
      defaultEditor = true;
    };
  };

}
