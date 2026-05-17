return {
  {
    "ojroques/vim-oscyank",
    config = function()
      -- Should be accompanied by a setting clipboard in tmux.conf, also see
      -- https://github.com/ojroques/vim-oscyank#the-plugin-does-not-work-with-tmux
      vim.g.oscyank_term = "default"
      vim.g.oscyank_max_length = 0 -- unlimited
      -- Below autocmd is for copying to OSC52 for any yank operation,
      -- see https://github.com/ojroques/vim-oscyank#copying-from-a-register
      vim.api.nvim_create_autocmd("TextYankPost", {
        pattern = "*",
        callback = function()
          if vim.v.event.operator == "y" and vim.v.event.regname == "" then
            vim.cmd('OSCYankRegister "')
          end
        end,
      })
    end,
  },
  {
    "ojroques/nvim-osc52",
    config = function()
      require("osc52").setup({
        max_length = 0, -- Maximum length of selection (0 for no limit)
        silent = false, -- Disable message on successful copy
        trim = false, -- Trim surrounding whitespaces before copy
      })
      local function copy()
        if (vim.v.event.operator == "y" or vim.v.event.operator == "d") and vim.v.event.regname == "" then
          require("osc52").copy_register("")
        end
      end

      vim.api.nvim_create_autocmd("TextYankPost", { callback = copy })
    end,
  },
}
