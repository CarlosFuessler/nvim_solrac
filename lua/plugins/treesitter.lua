return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local config = require("nvim-treesitter.configs")
    config.setup({
      ensure_installed = { "lua", "javascript", "c", "rust", "markdown" },
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
