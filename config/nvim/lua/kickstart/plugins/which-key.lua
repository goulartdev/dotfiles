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
      b = { name = 'Buffer', _ = 'which_key_ignore' },
      c = { name = 'Code', _ = 'which_key_ignore' },
      g = { name = 'Git', _ = 'which_key_ignore' },
      h = { name = 'Hunk', _ = 'which_key_ignore' },
      o = { name = 'Open', _ = 'which_key_ignore' },
      r = { name = 'Rename/Replace', _ = 'which_key_ignore' },
      s = { name = 'Search', _ = 'which_key_ignore' },
      u = { name = 'Update', _ = 'which_key_ignore' },
    }, { prefix = '<leader>' })

    require('which-key').register({
      ['1'] = 'which_key_ignore',
      ['2'] = 'which_key_ignore',
      ['3'] = 'which_key_ignore',
      ['4'] = 'which_key_ignore',
      ['5'] = 'which_key_ignore',
      ['6'] = 'which_key_ignore',
      ['7'] = 'which_key_ignore',
      ['8'] = 'which_key_ignore',
      ['9'] = 'which_key_ignore',
    }, { prefix = 'g' })
  end,
}

-- vim: ts=2 sts=2 sw=2 et
