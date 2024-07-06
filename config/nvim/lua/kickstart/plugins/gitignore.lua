return {
  'wintermute-cell/gitignore.nvim',
  keys = {
    { '<leader>gi', '<cmd>Gitignore<cr>', desc = 'Select gitignore template' },
  },
  config = function()
    require 'gitignore'
  end,
}
