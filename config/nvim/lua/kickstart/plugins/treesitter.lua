return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    'JoosepAlviste/nvim-ts-context-commentstring',
  },
  build = ':TSUpdate',
  keys = {
    { '<leader>ut', '<cmd>TSUpdate<cr>', desc = 'Update Treesitter parsers' },
  },
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require('nvim-treesitter.configs').setup {
      ensure_installed = {
        'angular',
        'bash',
        'c',
        'cpp',
        'css',
        'diff',
        'dockerfile',
        'gitignore',
        'gitcommit',
        'git_rebase',
        'html',
        'htmldjango',
        'javascript',
        'jsdoc',
        'json',
        'jsonc',
        'just',
        'kdl',
        'lua',
        'luadoc',
        'luap',
        'markdown',
        'markdown_inline',
        'python',
        'regex',
        'scss',
        'sql',
        'toml',
        'typescript',
        'vim',
        'vimdoc',
        'yaml',
        'zig',
      },
      auto_install = false,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = {
        enable = true,
        disable = { 'ruby' },
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<c-space>',
          node_incremental = '<c-space>',
          scope_incremental = false,
          node_decremental = '<bs>',
        },
      },
      textobjects = {
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            [']p'] = '@parameter.outer',
            [']f'] = '@function.outer',
            [']c'] = '@class.outer',
          },
          goto_next_end = {
            [']F'] = '@function.outer',
            [']C'] = '@class.outer',
          },
          goto_previous_start = {
            ['[p'] = '@parameter.outer',
            ['[f'] = '@function.outer',
            ['[c'] = '@class.outer',
          },
          goto_previous_end = {
            ['[F'] = '@function.outer',
            ['[C'] = '@class.outer',
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ['sp'] = '@parameter.inner',
            ['se'] = '@element',
          },
          swap_previous = {
            ['sP'] = '@parameter.inner',
            ['sE'] = '@element',
          },
        },
      },
    }
  end,
}
-- vim: ts=2 sts=2 sw=2 et
