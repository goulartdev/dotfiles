return {
  'NeogitOrg/neogit',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'sindrets/diffview.nvim',
  },
  keys = {
    { '<leader>gg', '<cmd>Neogit<cr>', desc = 'open neoGit' },
  },
  opts = function()
    return {
      signs = {
        hunk = { '', '' },
      },
    }
  end,
  cmd = { 'Neogit' },
  config = true,
}

-- vim: ts=2 sts=2 sw=2 et
