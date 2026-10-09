return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "nix" },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        nixd = {
          nixpkgs = {
            expr = "import (builtins.getFlake(toString ./.)).inputs.nixpkgs { }",
          },
          options = {
            nixos = {
              expr = "let flake = builtins.getFlake(toString ./.); in flake.nixosConfigurations.nz.options",
            },
            home_manager = {
              expr = 'let flake = builtins.getFlake(toString ./.); in flake.homeConfigurations."sab@mbp16".options',
            },
            darwin = {
              expr = "let flake = builtins.getFlake(toString ./.); in flake.darwinConfigurations.mbp16.options",
            },
          },
        },
        nil_ls = {
          enabled = false,
        },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        nix = { "nixfmt" },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        nix = {},
      },
    },
  },
}
