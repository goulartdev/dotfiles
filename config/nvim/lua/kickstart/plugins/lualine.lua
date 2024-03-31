return {
  'nvim-lualine/lualine.nvim',
  opts = function()
    return {
      options = {
        icons_enabled = true,
        theme = 'onedark',
        component_separators = '|',
        section_separators = '',
        globalstatus = true,
      },
    }
  end,
}

-- vim: ts=2 sts=2 sw=2 et
