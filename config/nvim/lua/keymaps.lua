vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.keymap.set('n', '<leader>of', vim.cmd.Ex, { desc = 'Open File explorer' })

vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll halfscreen down and center current line' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll halfscreen aup nd center current line' })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next search result and center line' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Prior search result and center line' })

vim.keymap.set('n', '<leader>rw', [[:%s/\<<C-r><C-w>\>//gI<Left><Left><Left>]], { desc = 'Replace current Word (buffer)' })

vim.keymap.set('v', '<leader>p', [["_dP]], { desc = 'Paste without yanking' })

vim.keymap.set('n', 'x', '"_x', { desc = 'Delete current character without yanking' })
vim.keymap.set('n', 'cl', '"_cl', { desc = 'Change current character without yanking' })
vim.keymap.set('n', 'dl', '"_dl', { desc = 'Delete current character without yanking' })

vim.keymap.set('n', '<C-c>', '<cmd>bw<cr>', { desc = 'Close current buffer' })

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'help',
  group = vim.api.nvim_create_augroup('HelpMappings', { clear = true }),
  callback = function(ev)
    vim.keymap.set('n', '<esc>', '<cmd>bw<cr>', { desc = 'Close current buffer', buffer = ev.buf })
    vim.keymap.set('n', 'q', '<cmd>bw<cr>', { desc = 'Close current buffer', buffer = ev.buf })
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'newsboat',
  group = vim.api.nvim_create_augroup('NewsboarMappings', { clear = true }),
  callback = function(ev)
    vim.keymap.set('n', '<esc>', '<cmd>q!<cr>', { desc = 'Close current buffer', buffer = ev.buf })
    vim.keymap.set('n', 'q', '<cmd>q!<cr>', { desc = 'Close current buffer', buffer = ev.buf })
  end,
})

-- vim: ts=2 sts=2 sw=2 et
