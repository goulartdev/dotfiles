-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

vim.opt.relativenumber = true;

lvim.builtin.nvimtree.active = true
lvim.colorscheme = "onedark_dark"

lvim.plugins = {
  { "lunarvim/colorschemes" },
  { "ThePrimeagen/vim-be-good" },
  { "NvChad/nvim-colorizer.lua",
    config = function()
       require("colorizer").setup()
    end
  },
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000,
    config = function()
      require("onedarkpro").setup({
        highlights = {
--          ["@constant.regex"] = { fg = "${green}", extend = true },
--          ["@field"] = { fg = "${white}", extend = true },
--          ["@type"] = { fg = "${white}", extend = true },
--          ["@property"] = { fg = "${white}", extend = true },
--          ["@parameter"] = { fg = "${orange}", extend = true },
--          ["@function.builtin"] = { fg = "${blue}", extend = true },

          ["@constant.python"] = { fg = "${white}", extend = true },
          ["@variable.python"] = { fg = "${white}", extend = true },
          ["@keyword.python"] = { fg = "${red}", extend = true },
          ["@keyword.return.python"] = { fg = "${red}", extend = true },
          ["@keyword.function.python"] = { fg = "${red}", extend = true },
          ["@conditional.python"] = { fg = "${red}", extend = true },
          ["@include.python"] = { fg = "${red}", extend = true },
          ["@exception.python"] = { fg = "${red}", extend = true },
          ["@function.python"] = { fg = "${blue}", extend = true },
          ["@type.python"] = { fg = "${blue}", extend = true },
          ["@operator.python"] = { fg = "${red}", extend = true },
          ["@number.python"] = { fg = "${purple}", extend = true },
          ["@boolean.python"] = { fg="${purple}", extend = true},
          ["@constant.builtin.python"] = { fg = "${white}", extend = true },
          ["@punctuation.bracket.regex"] = { fg = "${cyan}", extend = true },
          ["@odp.import_module.python"] = { fg = "${white}", extend = true },
          ["@odp.operator.splat.python"] = { fg = "${red}", extend = true },
          ["@odp.punctuation.brace.python"] = { link = "@punctuation.bracket.python" },
          ["@odp.keyword.python"] = { link = "@keyword.python"},

          ["@function.builtin.bash"] = { link = "@function.call.bash" }
        },
        options = {
          cursorline = true,
          terminal_colors = false
        }
      })
    end
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        close_if_last_window = false,
        enable_git_status = true,
        window = {
          width = 30,
        },
        buffers = {
          follow_current_file = {
            enable = true
          },
        },
        filesystem = {
          follow_current_file = {
            enalbe = true
          },
          filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = false,
            hide_by_name = {
              "node_modules",
              "__pycache__"
            },
            never_show = {
              ".DS_Store",
              "thumbs.db"
            },
          },
        },
      })
    end
  },
  { "nvim-treesitter/playground" }
}



