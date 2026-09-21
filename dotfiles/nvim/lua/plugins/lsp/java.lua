-- Injects --java-executable into jdtls cmd using JAVA_HOME from direnv.

local cache = {}

local function resolve_java_executable(dir)
  if cache[dir] ~= nil then
    return cache[dir] ~= false and cache[dir] or nil
  end

  local java_exe = nil

  if vim.fn.findfile(".envrc", dir) ~= "" then
    local r = vim
      .system({ "direnv", "exec", dir, "sh", "-c", "printf '%s' \"$JAVA_HOME\"" }, { text = true, timeout = 5000 })
      :wait()

    if r.code == 0 and r.stdout and r.stdout ~= "" then
      local exe = r.stdout .. "/bin/java"
      if vim.fn.filereadable(exe) == 1 then
        java_exe = exe
      end
    end
  end

  cache[dir] = java_exe or false
  return java_exe
end

return {
  {
    "mfussenegger/nvim-jdtls",
    opts = function(_, opts)
      opts.jdtls = function(config)
        local dir = config.root_dir or vim.fn.getcwd()
        local java_exe = resolve_java_executable(dir)

        if java_exe then
          config.cmd = config.cmd or { "jdtls" }
          table.insert(config.cmd, 2, "--no-validate-java-version")
          table.insert(config.cmd, 2, java_exe)
          table.insert(config.cmd, 2, "--java-executable")
        end

        return config
      end

      return opts
    end,
  },
}
