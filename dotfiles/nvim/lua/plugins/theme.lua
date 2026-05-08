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
      vim.api.nvim_set_hl(0, "NeoTreeRootName", { fg = "#c1c497", bold = true, italic = true })
      vim.api.nvim_set_hl(0, "NeoTreeDotfile", { fg = "#53685b" })
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
    "lukas-reineke/virt-column.nvim",
    opts = {
      virtcolumn = "80,120",
    },
  },
}
