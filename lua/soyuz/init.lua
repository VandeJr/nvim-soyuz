local M = {}

local defaults = {
  treesitter = {
    enable = true,
    parser_url = "https://github.com/VandeJr/tree-sitter-soyuz",
    branch = "main",
  },
  lsp = {
    enable = true,
    auto_install = true,
    version = "v0.1.0",
    name = "soyuz_lsp",
    root_markers = { "soyuz.toml", ".git" },
  },
}

local function setup_filetype()
  vim.filetype.add({
    extension = {
      sy = "soyuz",
      soyuz = "soyuz",
    },
  })
end

function M.setup(opts)
  opts = vim.tbl_deep_extend("force", defaults, opts or {})

  setup_filetype()

  if opts.treesitter and opts.treesitter.enable then
    require("soyuz.treesitter").setup(opts.treesitter)
  end

  if opts.lsp and opts.lsp.enable then
    require("soyuz.lsp").setup(opts.lsp)
  end
end

return M
