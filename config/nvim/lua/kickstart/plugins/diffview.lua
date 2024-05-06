return {
  'sindrets/diffview.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = function()
    local diffview = require 'diffview'
    local actions = require 'diffview.actions'

    local pfx = function(keys)
      return '<localleader>' .. keys
    end

    return {
      enhanced_diff_hl = true,
      file_panel = {
        listing_style = 'list',
      },
      keymaps = {
        view = {
          { 'n', pfx 'e', actions.focus_files, { desc = 'Bring focus to the file panel' } },
          { 'n', pfx 'b', actions.toggle_files, { desc = 'Toggle the file panel.' } },
          { 'n', pfx 'co', actions.conflict_choose 'ours', { desc = 'Choose Ours' } },
          { 'n', pfx 'ct', actions.conflict_choose 'theirs', { desc = 'Choose Theirs' } },
          { 'n', pfx 'cb', actions.conflict_choose 'base', { desc = 'Choose Base' } },
          { 'n', pfx 'ca', actions.conflict_choose 'all', { desc = 'Choose All' } },
          { 'n', 'dc', actions.conflict_choose 'none', { desc = 'Delete Conflict region' } },
          { 'n', pfx 'cO', actions.conflict_choose_all 'ours', { desc = 'Choose Ours (whole file)' } },
          { 'n', pfx 'cT', actions.conflict_choose_all 'theirs', { desc = 'Choose Theirs (whole file)' } },
          { 'n', pfx 'cB', actions.conflict_choose_all 'base', { desc = 'Choose Base (whole file)' } },
          { 'n', pfx 'cA', actions.conflict_choose_all 'all', { desc = 'Choose All (whole file)' } },
          { 'n', 'dC', actions.conflict_choose_all 'none', { desc = 'Delete Conflict region (whole file)' } },
          { 'n', 'q', diffview.close, { desc = 'Quit diffview' } },
        },
        file_panel = {
          { 'n', 'q', diffview.close, { desc = 'Quit diffview' } },
        },
        file_history_panel = {
          { 'n', 'q', diffview.close, { desc = 'Quit diffview' } },
        },
      },
      icons = {
        folder_closed = require('icons').ui.Folder,
        folder_open = require('icons').ui.FolderOpen,
      },
      signs = {
        fold_closed = require('icons').ui.ChevronRight,
        fold_open = require('icons').ui.ChevronDown,
        done = require('icons').ui.Check,
      },
      hooks = {
        diff_buf_read = function(bufnr)
          vim.opt_local.wrap = false
          vim.opt_local.list = false

          require('colorizer').detach_from_buffer(bufnr)
          require('which-key').register({
            c = { name = 'Conflict Choose', _ = 'which_key_ignore' },
          }, {
            buffer = bufnr,
            prefix = '<localleader>',
          })
        end,
      },
    }
  end,
  keys = {
    { '<leader>gh', '<cmd>DiffviewFileHistory %<cr>', desc = 'Git History (buffer)' },
    { '<leader>gH', '<cmd>DiffviewFileHistory<cr>', desc = 'Git History (branch)' },
    { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'Git Diff current index' },
  },
  cmd = { 'DiffviewFileHistory', 'DiffviewOpen' },
}
