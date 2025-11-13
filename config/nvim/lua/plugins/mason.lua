return {
  {
    "mason-org/mason.nvim",
    enabled = vim.g.enable_mason,
    opts = {
      ui = {
        border = "rounded",
      },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    enabled = vim.g.enable_mason,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    enabled = vim.g.enable_mason,
  },
}
