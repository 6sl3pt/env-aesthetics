-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function delete_empty_buffers()
  local buffers = vim.api.nvim_list_bufs()
  for _, bufnr in ipairs(buffers) do
    if vim.api.nvim_buf_is_loaded(bufnr) then
      local name = vim.api.nvim_buf_get_name(bufnr)
      local byte_count = vim.api.nvim_buf_get_offset(bufnr, vim.api.nvim_buf_line_count(bufnr))

      -- Check if name is empty and buffer has no content
      if name == "" and byte_count <= 1 then
        vim.api.nvim_buf_delete(bufnr, { force = true })
      end
    end
  end
  print("Cleaned empty buffers")
end

vim.keymap.set("n", "<leader>bn", delete_empty_buffers, { desc = "Delete empty [No Name] buffers" })
