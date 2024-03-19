return {
  'folke/todo-comments.nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    signs = false,
  },
  cmd = { 'TodoTrouble' },
  keys = {
    { '<leader>oc', '<cmd>TodoTrouble<cr>', desc = 'Open todo Comments' },
  },
}

-- vim: ts=2 sts=2 sw=2 et
