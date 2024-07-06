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
  keys = {
    { '<leader>rf', '<cmd>lua require("spectre").toggle()<cr>', desc = 'Replace in cwd Files (spectre)' },
  },
}

-- vim: ts=2 sts=2 sw=2 et
