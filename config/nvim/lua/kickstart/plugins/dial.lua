return {
  'monaqa/dial.nvim',
  config = function()
    local function manipulate(direction, mode)
      return function()
        require('dial.map').manipulate(direction, mode)
      end
    end

    vim.keymap.set('n', '<C-a>', manipulate('increment', 'normal'), { desc = 'Increment' })
    vim.keymap.set('n', '<C-x>', manipulate('decrement', 'normal'), { desc = 'Decrement' })
    vim.keymap.set('n', 'g<C-a>', manipulate('increment', 'gnormal'), { desc = 'Increment' })
    vim.keymap.set('n', 'g<C-x>', manipulate('decrement', 'gnormal'), { desc = 'Decrement' })

    vim.keymap.set('v', '<C-a>', manipulate('increment', 'visual'), { desc = 'Increment' })
    vim.keymap.set('v', '<C-x>', manipulate('decrement', 'visual'), { desc = 'Decrement' })
    vim.keymap.set('v', 'g<C-a>', manipulate('increment', 'gvisual'), { desc = 'Increment' })
    vim.keymap.set('v', 'g<C-x>', manipulate('decrement', 'gvisual'), { desc = 'Decrement' })

    local augend = require 'dial.augend'

    require('dial.config').augends:register_group {
      default = {
        augend.integer.alias.decimal,
        augend.integer.alias.hex,
        augend.date.alias['%Y-%m-%d'],
        augend.date.alias['%H:%M'],
        augend.constant.alias.bool,
        augend.constant.new {
          elements = { 'and', 'or' },
          word = true,
          cyclic = true,
        },
        augend.constant.new {
          elements = { '&&', '||' },
          word = false,
          cyclic = true,
        },
      },
    }
  end,
}

-- vim: ts=2 sts=2 sw=2 et
