return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      kdl = { "kdlfmt" },
      python = { "ruff_format", "ruff_organize_imports" },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
