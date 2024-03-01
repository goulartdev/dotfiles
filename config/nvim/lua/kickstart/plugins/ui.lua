return {
  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      signs = false
    }
  },
  {
    'navarasu/onedark.nvim',
    priority = 1000,
    lazy = false,
    config = function()
      require('onedark').setup {
        style = 'darker',
        transparent = true,
        highlights = {
          CursorLine = { bg = '$bg_d' },
          IblScope = { fg = '$dark_purple', fmt = "nocombine" },
        }
      }
      require('onedark').load()
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = false,
        theme = 'onedark',
        component_separators = '|',
        section_separators = '',
      },
    },
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
      indent = {
        char = '┊'
      },
      scope = {
        char = '│',
        show_start = false,
        show_end = false,
      }
    },
  },
}
