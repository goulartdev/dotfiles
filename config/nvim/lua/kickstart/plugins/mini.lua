return {
  {
    'echasnovski/mini.nvim',
    config = function()
      local ai = require 'mini.ai'

      ai.setup {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({
            a = { '@block.outer', '@conditional.outer', '@loop.outer' },
            i = { '@block.inner', '@conditional.inner', '@loop.inner' },
          }, {}),
          f = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }, {}),
          c = ai.gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' }, {}),
          a = ai.gen_spec.treesitter({ a = '@parameter.outer', i = '@parameter.inner' }, {}),
          t = { '<([%p%w]-)%f[^<%w][^<>]->.-</%1>', '^<.->().*()</[^/]->$' },
        },
      }

      require('mini.bufremove').setup()
      require('mini.jump').setup()
      require('mini.pairs').setup()
      require('mini.splitjoin').setup()
      require('mini.surround').setup()
    end,
  },
  {
    'echasnovski/mini.icons',
    lazy = true,
    init = function()
      package.preload['nvim-web-devicons'] = function()
        require('mini.icons').mock_nvim_web_devicons()
        return package.loaded['nvim-web-devicons']
      end
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
