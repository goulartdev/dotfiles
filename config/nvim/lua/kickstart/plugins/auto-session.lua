return {
  {
    'rmagatti/auto-session',
    lazy = false,
    opts = {
      auto_session_create_enabled = false,
      auto_save_enabled = true,
      auto_restore_enabled = true,
    },
    keys = {
      { '<leader>S', '<cmd>SessionSave<cr>', desc = 'Save session' },
    },
  },
  {
    'rmagatti/session-lens',
    requires = {
      'rmagatti/auto-session',
      'nvim-telescope/telescope.nvim',
    },
    opts = {},
    keys = {
      { '<leader>ss', '<cmd>Telescope session-lens search_session<cr>', desc = 'Search Sessions' },
    },
  },
}
