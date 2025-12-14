return {
  {
    "nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "angular", "scss" })
      end
      -- vim.api.nvim_create_autocmd({ "bufreadpost", "bufnewfile" }, {
      --   pattern = { "*.html" },
      --   callback = function()
      --     vim.treesitter.start(nil, "angular")
      --   end,
      -- })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        angularls = {
          -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#angularls
          -- https://github.com/angular/vscode-ng-language-service
          mason = false,
        },
      },
      setup = {
        angularls = function()
          Snacks.util.lsp.on({ name = "angularls" }, function(_, client)
            client.server_capabilities.renameProvider = false
          end)
        end,
      },
    },
  },
  -- {
  --   "conform.nvim",
  --   opts = function(_, opts)
  --     if LazyVim.has_extra("formatting.prettier") then
  --       opts.formatters_by_ft = opts.formatters_by_ft or {}
  --       opts.formatters_by_ft.htmlangular = { "prettier" }
  --     end
  --   end,
  -- }
}
