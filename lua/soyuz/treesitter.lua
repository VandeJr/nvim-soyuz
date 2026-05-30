local M = {}

local group = vim.api.nvim_create_augroup("nvim_soyuz_treesitter", { clear = true })

local function parser_definition(opts)
  opts = opts or {}

  return {
    install_info = {
      url = opts.parser_url or "https://github.com/VandeJr/tree-sitter-soyuz",
      files = { "src/parser.c" },
      branch = opts.branch or "main",
      generate_requires_npm = false,
      requires_generate_from_grammar = false,
    },
    filetype = "soyuz",
    tier = 3,
  }
end

local function register_parser(opts)
  local ok, parsers = pcall(require, "nvim-treesitter.parsers")
  if not ok then
    vim.notify("nvim-soyuz: nvim-treesitter is required for parser setup", vim.log.levels.WARN)
    return
  end

  local parser_config = parsers
  if type(parsers.get_parser_configs) == "function" then
    parser_config = parsers.get_parser_configs()
  end

  parser_config.soyuz = parser_definition(opts)
end

function M.setup(opts)
  opts = opts or {}

  register_parser(opts)

  -- nvim-treesitter reloads its parser table during :TSInstall/:TSUpdate and
  -- then emits User TSUpdate so plugins can re-apply custom parser entries.
  vim.api.nvim_create_autocmd("User", {
    group = group,
    pattern = "TSUpdate",
    callback = function()
      register_parser(opts)
    end,
  })
end

return M
