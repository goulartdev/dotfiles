require('lazy').setup({
  -- 'tpope/vim-sleuth',
  require 'kickstart.plugins.gitsigns',
  require 'kickstart.plugins.diffview',
  require 'kickstart.plugins.neogit',
  require 'kickstart.plugins.which-key',
  require 'kickstart.plugins.telescope',
  require 'kickstart.plugins.mason',
  require 'kickstart.plugins.lspconfig',
  require 'kickstart.plugins.conform',
  require 'kickstart.plugins.cmp',
  require 'kickstart.plugins.nvim-lint',
  require 'kickstart.plugins.onedark',
  require 'kickstart.plugins.colorizer',
  require 'kickstart.plugins.todo-comments',
  require 'kickstart.plugins.bufferline',
  require 'kickstart.plugins.lualine',
  require 'kickstart.plugins.ident-blankline',
  require 'kickstart.plugins.mini',
  require 'kickstart.plugins.treesitter',
  require 'kickstart.plugins.debug',
  require 'kickstart.plugins.notify',
  require 'kickstart.plugins.trouble',
  require 'kickstart.plugins.dial',
  require 'kickstart.plugins.spectre',
  require 'kickstart.plugins.text-case',
  require 'kickstart.plugins.auto-session',
  require 'kickstart.plugins.typescript-tools',
  require 'kickstart.plugins.lazydev',
  require 'kickstart.plugins.gitignore',
}, {
  install = {
    colorscheme = { 'onedark' },
  },
  ui = {
    border = 'rounded',
  },
  diff = {
    cmd = 'diffview.nvim',
  },
})

-- vim: ts=2 sts=2 sw=2 et
