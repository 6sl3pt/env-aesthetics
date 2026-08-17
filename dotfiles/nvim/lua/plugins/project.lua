return {
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup({
        manual_mode = false,
        silent_chdir = true,
        scope_chdir = "global",
      })
    end,
  },
}
