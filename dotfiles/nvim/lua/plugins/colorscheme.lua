return {
  {
    "ribru17/bamboo.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("bamboo").load()
      require("bamboo").setup({})

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
      vim.api.nvim_set_hl(0, "FloatTitle", { fg = "#FF5345" })
      vim.api.nvim_set_hl(0, "SnacksPickerBorder", { fg = "#509475", bg = "none", nocombine = true })
      vim.api.nvim_set_hl(0, "SnacksPickerDir", { fg = "#53685b" })
      vim.api.nvim_set_hl(0, "SnacksPickerDirectory", { fg = "#63b07a" })
      vim.api.nvim_set_hl(0, "SnacksPickerPrompt", { fg = "#FF5345" })
      vim.api.nvim_set_hl(0, "SnacksPickerTitle", { fg = "#FF5345" })

      vim.api.nvim_set_hl(0, "MiniIconsJade", { fg = "#63b07a" })
    end,
  },

  {
    "LazyVim/LazyVim",
    opt = {
      colorscheme = "bamboo",
    },
  },

  {
    "akinsho/bufferline.nvim",
    opts = {
      highlights = {
        buffer_selected = {
          fg = "#88af6c",
          bold = false,
        },
      },
    },
  },

  {
    "mini.icons",
    config = function()
      require("mini.icons").setup({
        default = {
          directory = { hl = "MiniIconsJade" },
        },
        filetype = {
          gitignore = { hl = "MiniIconsOrange" },
        },
      })
    end,
  },
}
