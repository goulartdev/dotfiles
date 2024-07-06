return {
  'johmsalas/text-case.nvim',
  dependencies = { 'nvim-telescope/telescope.nvim' },
  opts = {
    default_keymappings_enabled = false,
  },
  keys = {
    { '<leader>cc', '<cmd>TextCaseOpenTelescopeLSPChange<cr>', desc = 'Code Case convert' },
    { 'gC', '<cmd>TextCaseOpenTelescopeQuickChange<cr>', desc = 'Case convert' },
    -- TODO: try to make this work
    -- function()
    --   local do_quick = true
    --
    --   if not vim.tbl_isempty(vim.lsp.get_active_clients { bufnr = 0 }) then
    --     do_quick = not pcall(require('textcase').open_telescope, 'lsp_change')
    --   end
    --
    --   if do_quick then
    --     require('textcase').open_telescope 'quick_change'
    --   end
    -- end,
  },
  cmd = {
    'TextCaseOpenTelescopeQuickChange',
    'TextCaseOpenTelescopeLSPChange',
    'TextCaseStartReplacingCommand',
  },
  config = function(_, opts)
    require('textcase').setup(opts)
    require('telescope').load_extension 'textcase'
  end,
}
