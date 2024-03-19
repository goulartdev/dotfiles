return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  opts = {
    window = {
      border = 'single',
    },
  },
  keys = {
    {
      '<localleader>',
      function()
        require('which-key').show ','
      end,
    },
  },
  config = function(_, opts)
    require('which-key').setup(opts)

    -- Document existing key chains
    require('which-key').register({
      c = { name = 'Code', _ = 'which_key_ignore' },
      g = { name = 'Git', _ = 'which_key_ignore' },
      h = { name = 'Hunk', _ = 'which_key_ignore' },
      o = { name = 'Open', _ = 'which_key_ignore' },
      r = { name = 'Rename/Replace', _ = 'which_key_ignore' },
      s = { name = 'Search', _ = 'which_key_ignore' },
    }, { prefix = '<leader>' })
  end,
}
-- vim: ts=2 sts=2 sw=2 et
