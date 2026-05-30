# nvim-soyuz

Neovim plugin for the Soyuz programming language.

It configures:

- `.sy` and `.soyuz` filetypes.
- Tree-sitter parser installation through `nvim-treesitter`.
- Soyuz Tree-sitter queries for highlights, indentation, folds, and locals.
- Soyuz LSP using Neovim's built-in `vim.lsp.config`/`vim.lsp.enable`.
- Automatic Linux x64 download of `soyuz-lsp` from GitHub Releases.

## Requirements

- Neovim 0.11 or newer.
- Linux x64.
- `curl` for automatic LSP installation.
- [`nvim-treesitter`](https://github.com/nvim-treesitter/nvim-treesitter) for parser installation.

## Installation with lazy.nvim

```lua
{
  "VandeJr/nvim-soyuz",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {},
}
```

Then install the parser with:

```vim
:TSInstall soyuz
```

If your `nvim-treesitter` setup uses `ensure_installed`, add `soyuz` after this plugin
has been loaded:

```lua
require("nvim-treesitter.configs").setup({
  ensure_installed = { "soyuz" },
  highlight = { enable = true },
  indent = { enable = true },
})
```

## Configuration

Default setup:

```lua
require("soyuz").setup()
```

With explicit options:

```lua
require("soyuz").setup({
  treesitter = {
    enable = true,
    parser_url = "https://github.com/VandeJr/tree-sitter-soyuz",
    branch = "main",
  },
  lsp = {
    enable = true,
    auto_install = true,
    version = "v0.1.0",
  },
})
```

The LSP binary is installed to:

```txt
stdpath("data")/soyuz/bin/soyuz-lsp
```

You can override the command if you manage the binary yourself:

```lua
require("soyuz").setup({
  lsp = {
    cmd = { "/usr/local/bin/soyuz-lsp" },
  },
})
```
