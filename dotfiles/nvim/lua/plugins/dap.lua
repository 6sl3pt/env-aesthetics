-- Fixes "jobstart({term=true}) requires unmodified buffer" on second Java DAP launch.

return {
  {
    "LazyVim/LazyVim",
    opts = {
      icons = {
        dap = {
          Breakpoint = { "", "DiagnosticError" },
          BreakpointCondition = { " ", "DiagnosticError" },
        },
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    optional = true,
    keys = {
      {
        "<F9>",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Debug: Toggle Breakpoint",
      },
      {
        "<F21>",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Debug: Breakpoint Confition (Shift+F9)",
      },
      {
        "<F5>",
        function()
          require("dap").continue()
        end,
        desc = "Debug: Run/Continue",
      },
      {
        "<F17>",
        function()
          require("dap").terminate()
        end,
        desc = "Debug: Terminate (Shift+F5)",
      },
      {
        "<F10>",
        function()
          require("dap").step_over()
        end,
        desc = "Debug: Step Over",
      },
      {
        "<F11>",
        function()
          require("dap").step_into()
        end,
        desc = "Debug: Step Into",
      },
      {
        "<F23>",
        function()
          require("dap").step_out()
        end,
        desc = "Debug: Step Out (Shift+F11)",
      },
      {
        "<F6>",
        function()
          require("dap").pause()
        end,
        desc = "Debug: Pause",
      },
    },
    opt = function()
      local dap = require("dap")

      vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticError", linehl = "", numhl = "" })

      dap.defaults.java.terminal_win_cmd = function()
        local buf = vim.api.nvim_create_buf(true, true)
        vim.cmd("belowright split")
        local win = vim.api.nvim_get_current_win()
        vim.api.nvim_win_set_buf(win, buf)
        return buf, win
      end
    end,
  },
}
