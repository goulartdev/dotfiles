return {
  {
    "nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "html", "css", "javascript", "jsdoc" })
      end
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- html = {
        --   -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#html
        --   -- https://github.com/hrsh7th/vscode-langservers-extracted
        --   mason = false,
        -- },
        -- cssls = {
        --   -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#cssls
        --   -- https://github.com/hrsh7th/vscode-langservers-extracted
        --   mason = false,
        -- },
        -- oxlint = {
        --   -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#oxlint
        --   -- https://oxc.rs
        --   mason = false
        -- },
        biome = {
          -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#biome
          -- https://biomejs.dev
          mason = false,
        },
        emmet_language_server = {
          -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#emmet_language_server
          -- https://github.com/olrtg/emmet-language-server
          mason = false,
        },
      },
    },
  },
}
