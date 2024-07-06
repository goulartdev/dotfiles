return {
  'neovim/nvim-lspconfig',
  dependencies = {
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

        if client == nil then
          return
        end

        local severity = { 'ERROR', 'WARN', 'INFO', 'INFO' }
        vim.notify(method.message, severity[params.type], {
          title = 'LSP | ' .. client.name,
        })
      end,
    }

    local lspconfig = require 'lspconfig'
    local navbuddy = require 'nvim-navbuddy'

    vim.keymap.set('n', '<leader>cn', navbuddy.open, { desc = 'Code Navegation' })

    local on_attach = function(client, bufnr)
      if client.server_capabilities.documentSymbolProvider then
        require('nvim-navic').attach(client, bufnr)
        navbuddy.attach(client, bufnr)
      end

      vim.api.nvim_create_autocmd('CursorHold', {
        buffer = bufnr,
        callback = function()
          local opts = {
            focusable = false,
            close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },
            border = 'rounded',
            source = 'always',
            prefix = ' ',
            scope = 'cursor',
          }
          vim.diagnostic.open_float(nil, opts)
        end,
      })
    end

    local servers = {
      -- ls = {
      --    cmd = {...},
      --    filetypes {...},
      --    capabilities = {...},
      --    settings = {...},
      -- }

      -- Some languages (like typescript) have entire language plugins that can be useful:
      --    https://github.com/pmizio/typescript-tools.nvim
      emmet_language_server = {
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#emmet_language_server
        -- https://github.com/olrtg/emmet-language-server
      },
      html = {
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#emmet_language_server
        -- https://github.com/hrsh7th/vscode-langservers-extracted
      },
      cssls = {
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#cssls
        -- https://github.com/hrsh7th/vscode-langservers-extracted
      },
      eslint = {
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#eslint
        -- https://github.com/hrsh7th/vscode-langservers-extracted
        -- https://github.com/microsoft/vscode-eslint
      },
      basedpyright = {
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#basedpyright
        -- https://github.com/detachhead/basedpyright?tab=readme-ov-file
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
        -- https://github.com/astral-sh/ruff-lsp
        on_attach = function(client, bufnr)
          on_attach(client, bufnr)
          client.server_capabilities.hoverProvider = false
        end,
        mason_skip = true,
      },
      angularls = {
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#angularls
        -- https://github.com/angular/vscode-ng-language-service
        -- https://github.com/NixOS/nixpkgs/issues/244019
      },
      zls = {
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#zls
        -- https://github.com/zigtools/zls
      },
      nginx_language_server = {
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#nginx_language_server
        -- https://pypi.org/project/nginx-language-server/
      },
      dockerls = {
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#dockerls
        -- https://github.com/rcjsuen/dockerfile-language-server-nodejs
      },
      docker_compose_language_service = {
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#docker_compose_language_service
        -- https://github.com/microsoft/compose-language-service
      },
      marksman = {
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#marksman
        -- https://github.com/artempyanykh/marksman
      },
      jsonls = {
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#jsonls
        -- https://github.com/hrsh7th/vscode-langservers-extracted
        settings = {
          json = {
            schemas = require('schemastore').json.schemas(),
            validate = { enable = true },
          },
        },
      },
      yamlls = {
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#yamlls
        -- https://github.com/redhat-developer/yaml-language-server
      },
      taplo = {
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#taplo
        -- https://taplo.tamasfe.dev/cli/usage/language-server.html
      },
      bashls = {
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#bashls
        -- https://github.com/bash-lsp/bash-language-server
        filetypes = { 'sh', 'zsh' },
      },
      autotools_ls = {
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#autotools_ls
        -- https://github.com/Freed-Wu/autotools-language-server
      },
      nil_ls = {
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#nil_ls
        -- https://github.com/oxalica/nil
        settings = {
          ['nil'] = {
            formatting = {
              command = { 'nixfmt' },
            },
          },
        },
      },
      lua_ls = {
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#lua_ls
        -- https://github.com/luals/lua-language-server
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

    local function setup_server(server_name, server)
      -- This handles overriding only values explicitly passed
      -- by the server configuration above. Useful when disabling
      -- certain features of an LSP (for example, turning off formatting for tsserver)
      server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
      server.on_attach = server.on_attach or on_attach
      server.handlers = handlers
      lspconfig[server_name].setup(server)
    end

    if vim.g.use_mason then
      require('mason').setup()

      local ensure_installed = vim.tbl_filter(function(server)
        return not servers[server].mason_skip
      end, vim.tbl_keys(servers or {}))

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
