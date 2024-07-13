return {
  'hrsh7th/nvim-cmp',
  version = false,
  event = 'InsertEnter',
  dependencies = {
    {
      'L3MON4D3/LuaSnip',
      dependencies = {
        {
          'rafamadriz/friendly-snippets',
          config = function()
            require('luasnip.loaders.from_vscode').lazy_load()
          end,
        },
      },
    },
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-buffer',
    'onsails/lspkind.nvim',
    'echasnovski/mini.icons',
  },
  opts = function()
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'
    local lspkind = require 'lspkind'
    local compare = cmp.config.compare

    return {
      enabled = function()
        local disabled = require 'cmp.config.default'().enabled()
        local context = require 'cmp.config.context'

        return disabled or context.in_treesitter_capture 'comment'
      end,
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      completion = {
        completeopt = 'menu,menuone,noinsert',
      },
      ---@diagnostic disable-next-line: missing-fields
      formatting = {
        format = lspkind.cmp_format {
          mode = 'symbol_text',
          symbol_map = require('mini.icons').list 'lsp',
          maxwidth = function()
            return math.floor(0.20 * vim.o.columns)
          end,
          ellipsis_char = '...',
          menu = {
            nvim_lsp = '[LSP]',
            nvim_lua = '[api]',
            path = '[path]',
            luasnip = '[snip]',
            buffer = '[buf]',
          },
        },
      },
      sorting = {
        comparators = { compare.sort_text },
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
        ['<cr>'] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Insert, select = true },
        ['<C-cr>'] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = false },
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
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
      }, {
        { name = 'path' },
        { name = 'buffer', keyword_length = 7 },
      }),
      window = {
        completion = cmp.config.window.bordered {
          winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:CursorLine,Search:None',
        },
        documentation = cmp.config.window.bordered {
          winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:CursorLine,Search:None',
        },
      },
    }

    -- cmp.setup.cmdline(':', {
    --   mapping = cmp.mapping.preset.cmdline(),
    --   sources = cmp.config.sources {
    --     { name = 'path' },
    --   },
    --   matching = { disallow_symbol_nonprefix_matching = false },
    -- })

    -- cmp.setup.cmdline({ '/', '?' }, {
    --   mapping = cmp.mapping.preset.cmdline(),
    --   sources = {
    --     { name = 'buffer' }
    --   }
    -- })
  end,
}

-- vim: ts=2 sts=2 sw=2 et
