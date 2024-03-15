return {
  'folke/trouble.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {},
  keys = {
    { '<leader>xd', '<cmd>TroubleToggle document_diagnostics<cr>', desc = 'Document Diagnostics (Trouble)' },
    { '<leader>xw', '<cmd>TroubleToggle workspace_diagnostics<cr>', desc = 'Workspace Diagnostics (Trouble)' },
    { '<leader>xl', '<cmd>TroubleToggle loclist<cr>', desc = 'Location List (Trouble)' },
    { '<leader>xq', '<cmd>TroubleToggle quickfix<cr>', desc = 'Quickfix List (Trouble)' },
    { 'gR', '<cmd>TroubleToggle lsp_references<cr>', desc = 'LSP Reference (Trouble)' },
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
      desc = 'Previous trouble/quickfix item',
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
      desc = 'Next trouble/quickfix item',
    },
  },
}
