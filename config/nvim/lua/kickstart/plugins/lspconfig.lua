return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'folke/neodev.nvim', opts = {} },
    { 'j-hui/fidget.nvim', opts = {} },
    { 'SmiteshP/nvim-navic', opts = { icons = require('icons').kind } },
    { 'b0o/SchemaStore.nvim' },
    {
      'SmiteshP/nvim-navbuddy',
      dependencies = {
        'MunifTanjim/nui.nvim',
      },
      opts = {
        icons = vim.tbl_map(function(value)
          return value .. ' '
        end, require('icons').kind),
        window = {
          border = 'rounded',
        },
      },
    },
    {
      'utilyre/barbecue.nvim',
      dependencies = {
        'nvim-tree/nvim-web-devicons',
      },
      opts = {
        attach_navic = false,
      },
    },
    { 'williamboman/mason.nvim', enabled = vim.g.use_mason },
    { 'williamboman/mason-lspconfig.nvim', enabled = vim.g.use_mason },
    { 'WhoIsSethDaniel/mason-tool-installer.nvim', enabled = vim.g.use_mason },
  },
  config = function()
    -- Brief Aside: **What is LSP?**
    --
    -- LSP is an acronym you've probably heard, but might not understand what it is.
    --
    -- LSP stands for Language Server Protocol. It's a protocol that helps editors
    -- and language tooling communicate in a standardized fashion.
    --
    -- In general, you have a "server" which is some tool built to understand a particular
    -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc). These Language Servers
    -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
    -- processes that communicate with some "client" - in this case, Neovim!
    --
    -- LSP provides Neovim with features like:
    --  - Go to definition
    --  - Find references
    --  - Autocompletion
    --  - Symbol Search
    --  - and more!
    --
    -- Thus, Language Servers are external tools that must be installed separately from
    -- Neovim. This is where `mason` and related plugins come into play.
    --
    -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
    -- and elegantly composed help section, :help lsp-vs-treesitter

    --  This function gets run when an LSP attaches to a particular buffer.
    --    That is to say, every time a new file is opened that is associated with
    --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
    --    function will be executed to configure the current buffer
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = event.buf, desc = desc })
        end

        local telescope = require 'telescope.builtin'

        map('gd', telescope.lsp_definitions, 'Goto Definition')
        map('gD', vim.lsp.buf.declaration, 'Goto Declaration')

        map('<leader>cs', telescope.lsp_document_symbols, 'Code Symbols (document)')
        map('<leader>cS', telescope.lsp_dynamic_workspace_symbols, 'Code Symbols (workspace)')
        map('<leader>cr', telescope.lsp_references, 'Code References')
        map('<leader>ci', telescope.lsp_implementations, 'Code Implementations')
        map('<leader>ct', telescope.lsp_type_definitions, 'Code Type definition')
        map('<leader>ca', vim.lsp.buf.code_action, 'Code Action')
        map('<leader>cf', function()
          vim.lsp.buf.format { async = true }
        end, 'Code Format')

        map('<leader>li', '<cmd>LspInfo<cr>', 'Lsp Info')

        -- TODO: List options with telescope (lspconfig.utils may help)
        -- map('<leader>lr', '<cmd>LspRestart<cr>', 'Lsp Restart')
        -- map('<leader>ls', '<cmd>LspStart<cr>', 'Lsp Start')
        -- map('<leader>lS', '<cmd>LspStop<cr>', 'Lsp Stop')
        map('<leader>ll', '<cmd>LspLog<cr>', 'Lsp Log')

        map('<leader>rv', vim.lsp.buf.rename, 'Rename Variable')

        map('K', vim.lsp.buf.hover, 'Hover DocumenLspStoptation')

        -- map('<leader>gC', '<cmd>TextCaseOpenTelescopeLSPChange<cr>', 'Code Case convert')

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            callback = vim.lsp.buf.clear_references,
          })
        end
      end,
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

    require('lspconfig.ui.windows').default_options = { border = 'rounded' }

    local handlers = {
      ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' }),
      ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' }),
      ['window/showMessage'] = function(_, method, params, client_id)
        local client = vim.lsp.get_client_by_id(client_id)
        local severity = { 'ERROR', 'WARN', 'INFO', 'INFO' }
        vim.notify(method.message, severity[params.type], {
          title = 'LSP | ' .. client.name,
        })
      end,
    }

    local servers = {
      -- ls = {
      --    cmd = {...},
      --    filetypes {...},
      --    capabilities = {...},
      --    settings = {...},
      -- }

      -- Some languages (like typescript) have entire language plugins that can be useful:
      --    https://github.com/pmizio/typescript-tools.nvim
      emmet_language_server = {},
      html = {},
      cssls = {},
      eslint = {},
      pyright = {
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pyright
        -- https://github.com/microsoft/pyright
        settings = {
          pyright = {
            -- Using Ruff's import organizer
            disableOrganizeImports = true,
          },
          python = {
            analysis = {
              -- Ignore all files for analysis to exclusively use Ruff for linting
              ignore = { '*' },
            },
          },
        },
      },
      ruff_lsp = {
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#ruff
        -- https://github.com/astral-sh/ruff
      },
      angularls = {},
      dockerls = {},
      docker_compose_language_service = {},
      marksman = {},
      jsonls = {
        settings = {
          json = {
            schemas = require('schemastore').json.schemas,
            validate = { enable = true },
          },
        },
      },
      yamlls = {},
      taplo = {},
      bashls = {
        filetypes = { 'sh', 'zsh' },
      },
      autotools_ls = {},
      nil_ls = {
        settings = {
          ['nil'] = {
            formatting = {
              command = { 'nixfmt' },
            },
          },
        },
      },
      lua_ls = {
        settings = {
          Lua = {
            completion = {
              callSnippet = 'Replace',
            },
            -- diagnostics = { disable = { 'missing-fields' } },
          },
        },
      },
    }

    local lspconfig = require 'lspconfig'
    local navbuddy = require 'nvim-navbuddy'

    vim.keymap.set('n', '<leader>cn', navbuddy.open, { desc = 'Code Navegation' })

    local on_attach = function(client, bufnr)
      if client.server_capabilities.documentSymbolProvider then
        require('nvim-navic').attach(client, bufnr)
        navbuddy.attach(client, bufnr)
      end
    end

    local function setup_server(server_name, server)
      -- This handles overriding only values explicitly passed
      -- by the server configuration above. Useful when disabling
      -- certain features of an LSP (for example, turning off formatting for tsserver)
      server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
      server.on_attach = on_attach
      server.handlers = handlers
      lspconfig[server_name].setup(server)
    end

    if vim.g.use_mason then
      require('mason').setup()

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua',
      })

      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            setup_server(server_name, servers[server_name] or {})
          end,
        },
      }
    else
      for server_name, server in pairs(servers) do
        setup_server(server_name, server)
      end
    end

    for _, sign in ipairs(vim.tbl_get(vim.diagnostic.config(), 'signs', 'values') or {}) do
      vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text .. ' ', numhl = sign.name })
    end
  end,
}

-- vim: ts=2 sts=2 sw=2 et
