return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'

    harpoon.setup()

    local toggle_opts = {
      title = ' Harpoon ',
      border = 'rounded',
      title_pos = 'center',
      ui_max_width = 90,
    }

    vim.keymap.set('n', '<leader>ha', function()
      harpoon:list():append()
    end, { desc = '[H]arpoon [A]ppend current buffer' })

    vim.keymap.set('n', '<leader>hr', function()
      harpoon:list():remove()
    end, { desc = '[H]arpoon [R]emove current buffer' })

    vim.keymap.set('n', '<C-h>', function()
      harpoon.ui:toggle_quick_menu(harpoon:list(), toggle_opts)
    end, { desc = '[H]arpoon [T]oggle quick menu' })

    for i = 1, 9, 1 do
      vim.keymap.set('n', 'g' .. i, function()
        harpoon:list():select(i)
      end, { desc = '[G]o to buffer [' .. i .. ']' })
    end

    vim.keymap.set('n', '<M-[>', function()
      harpoon:list():prev { ui_nav_wrap = true }
    end)

    vim.keymap.set('n', '<M-]>', function()
      harpoon:list():next { ui_nav_wrap = true }
    end)
  end,
}
