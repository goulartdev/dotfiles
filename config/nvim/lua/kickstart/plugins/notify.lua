return {
  'rcarriga/nvim-notify',
  lazy = false,
  keys = {
    {
      '<leader>n',
      function()
        require('notify').dismiss { silent = true, pending = true }
      end,
      desc = 'dimiss all Notifications',
    },
    { '<leader>sn', '<cmd>Telescope notify<cr>', desc = 'Search Notifications' },
  },
  opts = {
    timeout = 4000,
    max_height = function()
      return math.floor(vim.o.lines * 0.75)
    end,
    max_width = function()
      return math.floor(vim.o.columns * 0.3)
    end,
    on_open = function(win)
      vim.api.nvim_win_set_config(win, { zindex = 100 })
    end,
    render = 'wrapped-compact',
    stages = 'fade',
    icons = {
      ERROR = require('icons').diagnostics.BoldError,
      WARN = require('icons').diagnostics.BoldWarn,
      INFO = require('icons').diagnostics.BoldInfo,
      DEBUG = require('icons').diagnostics.BoldDebug,
      TRACE = require('icons').diagnostics.Trace,
    },
  },
  init = function()
    vim.notify = require 'notify'
  end,
}

-- vim: ts=2 sts=2 sw=2 et
