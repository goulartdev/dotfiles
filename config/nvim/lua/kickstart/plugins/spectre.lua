return {
  'nvim-pack/nvim-spectre',
  opts = {
    open_cmd = 'noswapfile vnew',
  },
  config = function()
    vim.keymap.set('n', '<leader>rf', require('spectre').toggle, {
      desc = '[R]eplace in [f]iles (spectre)',
    })

    vim.keymap.set('n', '<leader>rW', function()
      require('spectre').open_visual { select_word = true }
    end, { desc = '[R]eplace current [W]ord (spectre)' })

    vim.keymap.set('v', '<leader>rs', require('spectre').open_visual, {
      desc = '[R]eplace [s]election (spectre)',
    })
  end,
}
