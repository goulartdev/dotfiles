return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  opts = {
    icons = {
      rules = false,
    },
    win = {
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

    require('which-key').add {
      { '<leader>b', group = 'Buffer' },
      { '<leader>b_', hidden = true },
      { '<leader>c', group = 'Code' },
      { '<leader>c_', hidden = true },
      { '<leader>d', group = 'Debug' },
      { '<leader>d_', hidden = true },
      { '<leader>g', group = 'Git' },
      { '<leader>g_', hidden = true },
      { '<leader>h', group = 'Hunk' },
      { '<leader>h_', hidden = true },
      { '<leader>l', group = 'Lsp' },
      { '<leader>l_', hidden = true },
      { '<leader>o', group = 'Open' },
      { '<leader>o_', hidden = true },
      { '<leader>r', group = 'Rename/Replace' },
      { '<leader>r_', hidden = true },
      { '<leader>s', group = 'Search' },
      { '<leader>s_', hidden = true },
      { '<leader>u', group = 'Update' },
      { '<leader>u_', hidden = true },
    }

    require('which-key').add {
      { 'g1', hidden = true },
      { 'g2', hidden = true },
      { 'g3', hidden = true },
      { 'g4', hidden = true },
      { 'g5', hidden = true },
      { 'g6', hidden = true },
      { 'g7', hidden = true },
      { 'g8', hidden = true },
      { 'g9', hidden = true },
    }
  end,
}

-- vim: ts=2 sts=2 sw=2 et
