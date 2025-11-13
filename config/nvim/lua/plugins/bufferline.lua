return {
  "akinsho/bufferline.nvim",
  opts = function()
    local bufferline = require("bufferline")

    local options = {
      diagnostics = "nvim_lsp",
      always_show_bufferline = true,
      hover = { enabled = false },
      separator_style = { "", "" },
      show_buffer_icons = false,
      show_buffer_close_icons = false,
      show_close_icon = false,
      tab_size = 1,
      themable = true,
      diagnostics_indicator = function(_, _, _)
        return ""
      end,
      groups = {
        items = {
          bufferline.groups.builtin.pinned:with({
            icon = "󰐃",
          }),
        },
      },
    }

    return {
      options = options,
    }
  end,
}
