return {
  'folke/trouble.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  opts = {
    icons = {
      indent = {
        fold_open = require('icons').ui.ChevronDown,
        fold_closed = require('icons').ui.ChevronRight,
      },
    },
  },
  cmd = { 'Trouble' },
  keys = {
    { '<leader>cd', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Code Diagnostics (current buffer)' },
    { '<leader>cD', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Code Diagnostics' },
    { '<leader>ol', '<cmd>Trouble loclist toggle<cr>', desc = 'Location list' },
    { '<leader>oq', '<cmd>Trouble qflist toggle<cr>', desc = 'Quickfix list' },
    {
      '[q',
      function()
        if require('trouble').is_open() then
          require('trouble').prev()
        else
          local ok, err = pcall(vim.cmd.cprev)
          if not ok then
            vim.notify(err, vim.log.levels.ERROR)
          end
        end
      end,
      desc = 'Previous Quickfix item',
    },
    {
      ']q',
      function()
        if require('trouble').is_open() then
          require('trouble').next()
        else
          local ok, err = pcall(vim.cmd.cnext)
          if not ok then
            vim.notify(err, vim.log.levels.ERROR)
          end
        end
      end,
      desc = 'Next Quickfix item',
    },
  },
  config = function(_, opts)
    require('trouble').setup(opts)

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'Trouble',
      group = vim.api.nvim_create_augroup('TroubleMappings', { clear = true }),
      callback = function(ev)
        vim.keymap.set('n', '/', require('telescope.builtin').diagnostics, { desc = 'Close current buffer', buffer = ev.buf })
      end,
    })
  end,
}

-- vim: ts=2 sts=2 sw=2 et
