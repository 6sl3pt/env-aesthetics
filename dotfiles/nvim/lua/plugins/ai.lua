return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "folke/which-key.nvim",
  },
  config = function()
    require("codecompanion").setup({
      interactions = {
        chat = {
          adapter = "bob_acp",
        },
      },
      adapters = {
        acp = {
          bob_acp = function()
            local helpers = require("codecompanion.adapters.acp.helpers")
            return {
              name = "bob_acp",
              formatted_name = "Bob",
              type = "acp",
              roles = {
                llm = "assistant",
                user = "user",
              },
              commands = {
                default = {
                  "bob",
                  "acp",
                },
              },
              defaults = {
                mcpServers = {},
                timeout = 20000, -- 20 seconds
              },
              parameters = {
                protocolVersion = 1,
                clientCapabilities = {
                  fs = { readTextFile = true, writeTextFile = true },
                },
              },
              handlers = {
                setup = function(_)
                  return true
                end,
                auth = function(_)
                  return true
                end,
                form_messages = function(self, messages, capabilities)
                  return helpers.form_messages(self, messages, capabilities)
                end,
                on_exit = function(_, _) end,
              },
            }
          end,
        },
      },
    })

    local wk = require("which-key")
    wk.add({
      { "<leader>a", group = "+ai", icon = { icon = "󱚣 ", color = "cyan" } },
      { "<leader>aa", "<cmd>CodeCompanionActions<cr>", desc = "Actions", mode = { "n", "v" } },
      { "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle Chat", mode = { "n", "v" } },
      { "<leader>ai", "<cmd>CodeCompanion<cr>", desc = "Inline Prompt", mode = { "n", "v" } },
    })

    vim.cmd([[cab cc CodeCompanion]])
  end,
}
