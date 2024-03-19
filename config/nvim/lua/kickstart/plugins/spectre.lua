return {
  'nvim-pack/nvim-spectre',
  opts = {
    open_cmd = 'noswapfile vnew',
    default = {
      replace = {
        cmd = 'sd',
      },
    },
  },
  config = function()
    vim.keymap.set('n', '<leader>rf', require('spectre').toggle, {
      desc = 'Replace in cwd Files (spectre)',
    })
  end,
}

-- vim: ts=2 sts=2 sw=2 et
