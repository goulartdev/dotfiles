return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "python", "htmldjango" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ruff = {
          -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#ruff
          -- https://github.com/astral-sh/ruff
          cmd_env = { RUFF_TRACE = "messages" },
          init_options = {
            settings = {
              logLevel = "error",
            },
          },
          keys = {
            {
              "<leader>co",
              LazyVim.lsp.action["source.organizeImports"],
              desc = "Organize Imports",
            },
          },
          mason = false,
        },
        basedpyright = {
          -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#basedpyright
          -- https://github.com/detachhead/basedpyright
          settings = {
            pyright = {
              -- Using Ruff's import organizer
              disableOrganizeImports = true,
            },
            python = {
              analysis = {
                -- Ignore all files for analysis to exclusively use Ruff for linting
                ignore = { "*" },
              },
            },
          },
          capabilities = {
            workspace = {
              didChangeWatchedFiles = {
                dynamicRegistration = true,
              },
            },
          },
          -- on_attach = function(client, bufnr)
          --   client.server_capabilities.hoverProvider = false
          -- end,
          mason = false,
        },
        ty = {
          -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#ty
          -- https://github.com/astral-sh/ty
          mason = false,
        },
        -- pyrefly = {
        --   -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#pyrefly
        --   -- https://pyrefly.org/
        --   mason = false,
        -- },
        -- zuban = {
        --   -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#zuban
        --   -- https://zubanls.com/
        --   mason = false,
        -- }
      },
    },
    setup = {
      ["basedpyright"] = function()
        Snacks.util.lsp.on({ name = "basedpyright" }, function(_, client)
          client.server_capabilities.hoverProvider = false
        end)
      end,
    },
  },
}
