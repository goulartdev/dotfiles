return {
  'williamboman/mason.nvim',
  enabled = vim.g.use_mason,
  keys = {
    { '<leader>um', '<cmd>MasonUpdate<cr>', desc = 'Update Mason' },
  },
  opts = {
    ui = {
      border = 'rounded',
    },
  },
}
