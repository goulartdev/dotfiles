return {
  {
    'rmagatti/auto-session',
    opts = {
      log_level = 'error',
      auto_session_suppress_dirs = { '~/code' },
      auto_session_use_git_branch = true,
      auto_save_enabled = true,
      auto_restore_enabled = true,
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
      { '<leader>ss', '<cmd>Telescope session-lens search_session<cr>' },
    },
  },
}
