local install = require("soyuz.install")

local M = {}

local function set_lsp_config(name, config)
  if type(vim.lsp.config) == "function" then
    vim.lsp.config(name, config)
    return true
  end

  if type(vim.lsp.config) == "table" then
    vim.lsp.config[name] = config
    return true
  end

  return false
end

local function resolve_cmd(opts)
  if opts.cmd then
    return opts.cmd
  end

  if opts.auto_install then
    local ok, bin_or_err = pcall(install.ensure, opts)
    if not ok then
      vim.notify("nvim-soyuz: " .. bin_or_err, vim.log.levels.ERROR)
      return nil
    end

    return { bin_or_err }
  end

  return { "soyuz-lsp" }
end

function M.setup(opts)
  opts = opts or {}

  if type(vim.lsp.enable) ~= "function" or not vim.lsp.config then
    vim.notify("nvim-soyuz: vim.lsp.config and vim.lsp.enable are required", vim.log.levels.ERROR)
    return
  end

  local cmd = resolve_cmd(opts)
  if not cmd then
    return
  end

  local name = opts.name or "soyuz_lsp"
  local ok = set_lsp_config(name, {
    cmd = cmd,
    filetypes = opts.filetypes or { "soyuz" },
    root_markers = opts.root_markers or { "soyuz.toml", ".git" },
    settings = opts.settings,
    capabilities = opts.capabilities,
  })

  if not ok then
    vim.notify("nvim-soyuz: unsupported vim.lsp.config API", vim.log.levels.ERROR)
    return
  end

  vim.lsp.enable(name)
end

return M
