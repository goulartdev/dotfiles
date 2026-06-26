return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      kdl = { "kdlfmt" },
      python = { "ruff_format", "ruff_organize_imports" },
      javascript = { "biome-check" },
      typescript = { "biome-check" },
      json = { "biome-check" },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
