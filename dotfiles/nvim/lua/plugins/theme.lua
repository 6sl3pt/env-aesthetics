return {
  {
    "ribru17/bamboo.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("bamboo").load()
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
}
