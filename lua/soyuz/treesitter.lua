local M = {}

function M.setup(opts)
  opts = opts or {}

  local ok, parsers = pcall(require, "nvim-treesitter.parsers")
  if not ok then
    vim.notify("nvim-soyuz: nvim-treesitter is required for parser setup", vim.log.levels.WARN)
    return
  end

  local parser_config = parsers.get_parser_configs()
  parser_config.soyuz = {
    install_info = {
      url = opts.parser_url or "https://github.com/VandeJr/tree-sitter-soyuz",
      files = { "src/parser.c" },
      branch = opts.branch or "main",
      generate_requires_npm = false,
      requires_generate_from_grammar = false,
    },
    filetype = "soyuz",
  }
end

return M
