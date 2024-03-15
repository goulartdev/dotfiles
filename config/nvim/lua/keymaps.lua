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

-- https://github.com/ThePrimeagen/neovimrc/blob/f715b041310f89b11e68884c605b2b5d7a3f162b/lua/theprimeagen/remap.lua
vim.keymap.set('n', '<leader>ge', vim.cmd.Ex, { desc = '[G]o to netrw/[E]x' })

vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll halfscreen down and center current line' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll halfscreen aup nd center current line' })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next search result and center line' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Prior search result and center line' })

vim.keymap.set('n', '<leader>rw', [[:%s/\<<C-r><C-w>\>//gI<Left><Left><Left>]], { desc = '[R]eplace [W]ord' })

vim.keymap.set('x', '<leader>p', [["_dP]], { desc = 'Paste without yanking' })
vim.keymap.set('x', '<leader>d', [["_d]], { desc = 'Delete without yanking' })

vim.keymap.set('n', 'x', '"_x', { desc = 'Delete current character without yanking it' })
vim.keymap.set('n', 'cl', '"_cl', { desc = 'Change current character without yanking it' })
vim.keymap.set('n', 'dl', '"_dl', { desc = 'Delete current character without yanking it' })

vim.keymap.set('n', '<C-c>', '<cmd>bw<cr>', { desc = 'Wipeout current buffer' })

-- vim: ts=2 sts=2 sw=2 et
