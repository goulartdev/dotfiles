return {
  "neovim/nvim-lspconfig",
  -- dependencies = {
  --   { "b0o/SchemaStore.nvim" },
  --   {
  --     "SmiteshP/nvim-navic",
  --     dependencies = { "echasnovski/mini.icons" },
  --     opts = function()
  --       return {
  --         icons = require("mini.icons").list("lsp"),
  --       }
  --     end,
  --   },
  --   {
  --     "SmiteshP/nvim-navbuddy",
  --     dependencies = {
  --       "MunifTanjim/nui.nvim",
  --       "echasnovski/mini.icons",
  --     },
  --     opts = function()
  --       return {
  --         icons = vim.tbl_map(function(value)
  --           return value .. " "
  --         end, require("mini.icons").list("lsp")),
  --         window = {
  --           border = "rounded",
  --         },
  --       }
  --     end,
  --   },
  -- },
  opts = {
    servers = {
      -- ["*"] = {
      --   on_attach = function(client, bufnr)
      --     if client.server_capabilities.documentSymbolProvider then
      --       require("nvim-navic").attach(client, bufnr)
      --       require("nvim-navbuddy").attach(client, bufnr)
      --     end
      --   end,
      --   keys = {
      --     {
      --       "<leader>cn",
      --       require("nvim-navbuddy").open,
      --       desc = "Code Navegation",
      --       has = { "documentSymbolProvider" },
      --       mode = { "n" },
      --     },
      --   },
      -- },
      -- astro = {
      --   -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#astro
      --   -- https://github.com/withastro/language-tools/tree/main/packages/language-server
      --   mason = false,
      -- },
      zls = {
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#zls
        -- https://github.com/zigtools/zls
        mason = false,
      },
      postgres_lsp = {
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#postgres_lsp
        -- https://github.com/supabase/postgres_lspa
      },
      docker_language_server = {
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#dockerls
        -- https://github.com/rcjsuen/dockerfile-language-server-nodejs
      },
      nginx_language_server = {
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#nginx_language_server
        -- https://pypi.org/project/nginx-language-server/
      },
      marksman = {
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#marksman
        -- https://github.com/artempyanykh/marksman
      },
      taplo = {
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#taplo
        -- https://taplo.tamasfe.dev/cli/usage/language-server.html
      },
      typos_lsp = {
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#typos_lsp
        -- https://github.com/tekumara/typos-lsp
      },
      bashls = {
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#bashls
        -- https://github.com/bash-lsp/bash-language-server
        filetypes = { "sh", "zsh" },
      },
      hyprls = {
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#hyprls
        -- https://github.com/hyprland-community/hyprls
        mason = false,
      },
      yamlls = {
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#yamlls
        -- https://github.com/redhat-developer/yaml-language-server
      },
      -- jsonls = {
      --   -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#jsonls
      --   -- https://github.com/hrsh7th/vscode-langservers-extracted
      --   settings = {
      --     json = {
      --       schemas = require("schemastore").json.schemas(),
      --       validate = { enable = true },
      --     },
      --   },
      -- },
    },
  },
}
