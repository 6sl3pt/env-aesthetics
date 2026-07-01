return {
  {
    "ribru17/bamboo.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      local bamboo_group = vim.api.nvim_create_augroup("BambooOverrides", { clear = true })

      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        group = bamboo_group,
        callback = function(ev)
          local has_mini, mini = pcall(require, "mini.icons")

          if ev.match == "bamboo" then
            vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { fg = "#63b07a" })
            vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", { fg = "#63b07a" })
            vim.api.nvim_set_hl(0, "NeoTreeDotfile", { fg = "#53685b" })
            vim.api.nvim_set_hl(0, "NeoTreeRootName", { fg = "#c1c497", bold = true, italic = true })

            vim.api.nvim_set_hl(0, "NoiceCmdlineIcon", { fg = "#509475" })
            vim.api.nvim_set_hl(0, "NoiceCmdlineIconSearch", { fg = "#E5C736" })
            vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder", { fg = "#509475", bg = "NONE" })

            vim.api.nvim_set_hl(0, "SnacksDashboardDesc", { fg = "#53685b" })
            vim.api.nvim_set_hl(0, "SnacksDashboardFooter", { fg = "#53685b" })
            vim.api.nvim_set_hl(0, "SnacksDashboardHeader", { fg = "#53685b" })
            vim.api.nvim_set_hl(0, "SnacksDashboardIcon", { fg = "#53685b" })
            vim.api.nvim_set_hl(0, "SnacksDashboardKey", { fg = "#53685b" })
            vim.api.nvim_set_hl(0, "SnacksDashboardSpecial", { fg = "#53685b" })
            vim.api.nvim_set_hl(0, "SnacksDashboardTerminal", { fg = "#53685b" })

            vim.api.nvim_set_hl(0, "Directory", { fg = "#63b07a" })
            vim.api.nvim_set_hl(0, "FloatTitle", { fg = "#D2689C" })
            vim.api.nvim_set_hl(0, "SnacksPickerBorder", { fg = "#509475", bg = "none", nocombine = true })
            vim.api.nvim_set_hl(0, "SnacksPickerDir", { fg = "#53685b" })
            vim.api.nvim_set_hl(0, "SnacksPickerDirectory", { fg = "#63b07a" })
            vim.api.nvim_set_hl(0, "SnacksPickerPrompt", { fg = "#D2689C" })
            vim.api.nvim_set_hl(0, "SnacksPickerTitle", { fg = "#D2689C" })

            vim.api.nvim_set_hl(0, "MiniIconsJade", { fg = "#63b07a" })
            vim.api.nvim_set_hl(0, "BufferLineBufferSelected", { fg = "#88af6c", bold = false })

            if has_mini then
              mini.setup({
                default = {
                  directory = { hl = "MiniIconsJade" },
                },
                filetype = {
                  gitignore = { hl = "MiniIconsOrange" },
                },
              })
            end
          else
            if has_mini then
              mini.setup({})
            end
          end
        end,
      })

      -- require("bamboo").load()
      require("bamboo").setup({})
    end,
  },

  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_enable_italic = true
      vim.g.gruvbox_material_background = "soft"
      vim.g.gruvbox_material_diagnostic_virtual_text = true
      vim.o.background = "dark"
      vim.cmd.colorscheme("gruvbox-material")
    end,
  },

  {
    "LazyVim/LazyVim",
    opt = {
      colorscheme = "gruvbox-material",
    },
  },
}
