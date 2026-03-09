return {
  {
    "ribru17/bamboo.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("bamboo").load()
      vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { fg = "#88af6c" })
      vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", { fg = "#88af6c" })
      vim.api.nvim_set_hl(0, "NeoTreeRootName", { fg = "#c1c497", bold = true, italic = true })
    end,
  },
  {
    "LazyVim/LazyVim",
    opt = {
      colorscheme = "bamboo",
    },
  },
}
