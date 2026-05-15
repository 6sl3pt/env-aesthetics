return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        toml = { "taplo" },
      },
      formatters = {
        prettier = {
          args = function(ctx)
            local args = {
              "--stdin-filepath",
              "$FILENAME",
            }

            local config_files = {
              ".prettierrc",
              ".prettierrc.json",
              ".prettierrc.yml",
              ".prettierrc.yaml",
              ".prettierrc.js",
              ".prettierrc.cjs",
              "prettier.config.js",
              "prettier.config.cjs",
            }

            local has_config = vim.fs.find(config_files, { path = ctx.filename, upward = true })[1] ~= nil

            -- default prettier config
            if not has_config then
              vim.list_extend(args, {
                "--print-width",
                "80",
                "--prose-wrap",
                "always",
                "--tab-width",
                "2",
                "--trailing-comma",
                "all",
                "--single-quote",
              })
            end

            return args
          end,
        },
      },
    },
  },
}
