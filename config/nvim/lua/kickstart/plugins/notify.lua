return {
  "rcarriga/nvim-notify",
  lazy = false,
  keys = {
    {
      "<leader>nd",
      function()
        require("notify").dismiss({ silent = true, pending = true })
      end,
      desc = "[N]otifications [D]imiss all",
    },
  },
  opts = {
    timeout = 4000,
    max_height = function()
      return math.floor(vim.o.lines * 0.75)
    end,
    max_width = function()
      return math.floor(vim.o.columns * 0.4)
    end,
    on_open = function(win)
      vim.api.nvim_win_set_config(win, { zindex = 100 })
    end,
    render = "compact",
    stages = "fade",
  },
  init = function()
    vim.notify = require("notify")
  end,
}
