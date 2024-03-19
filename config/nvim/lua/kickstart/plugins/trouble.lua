return {
  'folke/trouble.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    fold_open = require('icons').ui.ChevronDown,
    fold_closed = require('icons').ui.ChevronRight,
    use_diagnostic_signs = true,
    include_declaration = {},
  },
  cmd = { 'Trouble', 'TroubleToggle' },
  keys = {
    { '<leader>cd', '<cmd>TroubleToggle document_diagnostics<cr>', desc = 'Code Diagnostics (document)' },
    { '<leader>cD', '<cmd>TroubleToggle workspace_diagnostics<cr>', desc = 'Code Diagnostics (workspace)' },
    { '<leader>ol', '<cmd>TroubleToggle loclist<cr>', desc = 'Open Location list' },
    { '<leader>oq', '<cmd>TroubleToggle quickfix<cr>', desc = 'Open Quickfix list' },
    {
      '[q',
      function()
        if require('trouble').is_open() then
          require('trouble').previous { skip_groups = true, jump = true }
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
          require('trouble').next { skip_groups = true, jump = true }
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
  config = function()
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
