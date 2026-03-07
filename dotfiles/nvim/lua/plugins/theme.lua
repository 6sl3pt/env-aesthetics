return {
  {
    "ribru17/bamboo.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("bamboo").load()
    end,
  },
  {
    "LazyVim/LazyVim",
    opt = {
      colorscheme = "bamboo",
    },
  },
}
