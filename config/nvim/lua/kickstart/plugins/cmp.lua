return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'rafamadriz/friendly-snippets',
    'onsails/lspkind.nvim',
  },
  config = function()
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'
    local lspkind = require 'lspkind'

    require('luasnip.loaders.from_vscode').lazy_load()

    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      completion = {
        completeopt = 'menu,menuone,noinsert',
      },
      formatting = {
        format = lspkind.cmp_format {
          mode = 'symbol_text',
          symbol_map = require('icons').kind,
          maxwidth = function()
            return math.floor(0.20 * vim.o.columns)
          end,
          ellipsis_char = '...',
          menu = {
            nvim_lsp = '[LSP]',
            nvim_lua = '[api]',
            path = '[path]',
            luasnip = '[snip]',
          },
        },
      },
      experimental = {
        native_menu = false,
        ghost_text = false,
      },
      mapping = cmp.mapping.preset.insert {
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete {},
        ['<C-y>'] = cmp.mapping.confirm { select = true },
        ['<C-e>'] = cmp.mapping.abort(),
        ['<C-l>'] = cmp.mapping(function()
          if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          end
        end, { 'i', 's' }),
        ['<C-h>'] = cmp.mapping(function()
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          end
        end, { 'i', 's' }),
      },
      sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
      },
      window = {
        completion = cmp.config.window.bordered {
          winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:CursorLine,Search:None',
        },
        documentation = cmp.config.window.bordered {
          winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:CursorLine,Search:None',
        },
      },
    }
  end,
}

-- vim: ts=2 sts=2 sw=2 et
