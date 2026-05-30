local M = {}

local function joinpath(...)
  return table.concat({ ... }, "/")
end

local function os_uname()
  local uv = vim.uv or vim.loop
  return uv.os_uname()
end

local function asset_name()
  local uname = os_uname()
  if uname.sysname ~= "Linux" then
    return nil, "only Linux is supported for automatic soyuz-lsp installation"
  end

  if uname.machine == "x86_64" or uname.machine == "amd64" then
    return "soyuz-lsp-linux-x64"
  end

  return nil, "unsupported Linux architecture: " .. uname.machine
end

local function release_url(version, asset)
  if version == "latest" then
    return "https://github.com/VandeJr/soyuz/releases/latest/download/" .. asset
  end

  return "https://github.com/VandeJr/soyuz/releases/download/" .. version .. "/" .. asset
end

function M.install_dir()
  return joinpath(vim.fn.stdpath("data"), "soyuz", "bin")
end

function M.bin_path(opts)
  opts = opts or {}
  return joinpath(opts.install_dir or M.install_dir(), "soyuz-lsp")
end

function M.ensure(opts)
  opts = opts or {}

  local bin = M.bin_path(opts)
  if not opts.force and vim.fn.executable(bin) == 1 then
    return bin
  end

  if vim.fn.executable("curl") ~= 1 then
    error("curl is required to download soyuz-lsp")
  end

  local asset, err = asset_name()
  if not asset then
    error(err)
  end

  local version = opts.version or "v0.1.0"
  local url = release_url(version, asset)
  local install_dir = opts.install_dir or M.install_dir()
  local tmp = bin .. ".tmp"

  vim.fn.mkdir(install_dir, "p")
  vim.notify("nvim-soyuz: downloading soyuz-lsp " .. version, vim.log.levels.INFO)

  local result = vim.system({
    "curl",
    "-fL",
    "--retry",
    "3",
    "--output",
    tmp,
    url,
  }, { text = true }):wait()

  if result.code ~= 0 then
    vim.fn.delete(tmp)
    error("failed to download soyuz-lsp: " .. (result.stderr or "unknown error"))
  end

  vim.fn.rename(tmp, bin)
  vim.fn.setfperm(bin, "rwxr-xr-x")

  return bin
end

return M
