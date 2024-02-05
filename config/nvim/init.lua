vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require 'lazy-bootstrap'
require 'lazy-plugins'
require 'options'
require 'keymaps'
require 'telescope-setup'
require 'treesitter-setup'
require 'lsp-setup'
require 'cmp-setup'

-- vim: ts=2 sts=2 sw=2 et

-- vim.lsp.set_log_level('DEBUG')
