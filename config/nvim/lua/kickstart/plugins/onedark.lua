return {
  'navarasu/onedark.nvim',
  priority = 1000,
  init = function()
    require('onedark').setup {
      style = 'darker',
      colors = {
        -- black = "#0e1013",
        bg0 = '#010909',
        -- bg1 = "#282c34",
        -- bg2 = "#30363f",
        -- bg3 = "#323641",
        -- bg_d = "#181b20",
        -- bg_blue = "#61afef",
        -- bg_yellow = "#e8c88c",
        -- fg = "#a0a8b7",
        -- purple = "#bf68d9",
        -- green = "#8ebd6b",
        -- orange = "#cc9057",
        -- blue = "#4fa6ed",
        -- yellow = "#e2b86b",
        -- cyan = "#48b0bd",
        -- red = "#e55561",
        -- grey = "#535965",
        -- light_grey = "#7a818e",
        -- dark_cyan = "#266269",
        -- dark_red = "#8b3434",
        -- dark_yellow = "#835d1a",
        -- dark_purple = "#7e3992",
        diff_add = '#002800',
        diff_delete = '#3f0001',
        diff_change = '#291c00',
        diff_text = '#493706',
      },
      highlights = {
        IblScope = { fg = '$dark_purple', fmt = 'nocombine' },
        NormalFloat = { fg = '$fg', bg = 'none' },
        FloatBorder = { fg = '$dark_purple', bg = 'none' },
        FloatTitle = { fg = '$red' },
        TelescopePromptBorder = { fg = '$dark_purple' },
        TelescopeResultsBorder = { fg = '$dark_purple' },
        TelescopePreviewBorder = { fg = '$dark_purple' },
        NavbuddyNormalFloat = { fg = '$dark_purple', bg = 'none' },
        MiniJump = { fg = 'white', bg = '$dark_purple' },
        BufferLineFill = { bg = '$black' },
        BufferLineBackground = { bg = '$bg_d' },
        BufferLineBufferSelected = { bg = '$bg0' },
        BufferLineBufferVisible = { bg = '$bg0' },
        BufferLineIndicatorSelected = { fg = '$dark_purple', bg = '$bg0' },
        BufferLineIndicatorVisible = { fg = '$dark_purple', bg = '$bg0' },
        BufferLineNumbers = { fg = '$orange', bg = '$bg_d' },
        BufferLineNumbersSelected = { fg = '$orange', bg = '$bg0' },
        BufferLineNumbersVisible = { fg = '$orange', bg = '$bg0' },
        BufferLineModified = { fg = '$green', bg = '$bg_d' },
        BufferLineModifiedSelected = { fg = '$green', bg = '$bg0' },
        BufferLineModifiedVisible = { fg = '$green', bg = '$bg0' },
        BufferLineGroupSeparator = { bg = '$bg_d' },
        BufferLineGroupLabel = { fg = '$fg', bg = '$bg_d' },
      },
    }
    require('onedark').load()
  end,
}

-- vim: ts=2 sts=2 sw=2 et
