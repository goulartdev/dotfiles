vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

vim.g.use_mason = vim.env.NVIM_USE_MASON == '1'

require 'options'
require 'keymaps'
require 'lazy-bootstrap'
require 'lazy-plugins'

-- vim.lsp.set_log_level('DEBUG')

-- vim: ts=2 sts=2 sw=2 et
