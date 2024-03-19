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

    vim.keymap.set('n', '<leader>ht', function()
      harpoon.ui:toggle_quick_menu(harpoon:list(), toggle_opts)
    end, { desc = '[H]arpoon [T]oggle quick menu' })

    for i = 1, 9, 1 do
      vim.keymap.set('n', 'g' .. i, function()
        harpoon:list():select(i)
      end, { desc = '[G]o to buffer [' .. i .. ']' })
    end

    -- vim.keymap.set('n', '<M-[>', function()
    --   harpoon:list():prev { ui_nav_wrap = true }
    -- end)
    --
    -- vim.keymap.set('n', '<M-]>', function()
    --   harpoon:list():next { ui_nav_wrap = true }
    -- end)

    local function pinned_list()
      local items = {}
      for _, item in ipairs(harpoon:list().items) do
        table.insert(items, {
          bufnr = vim.fn.bufnr(item.value, true),
          select = function()
            harpoon.config.default.select(item, harpoon:list())
          end,
        })
      end

      return items
    end

    local function open_switcher()
      local Path = require 'plenary.path'

      vim.ui.select(pinned_list(), {
        prompt = ' Buffers ',
        format_item = function(item)
          local path = vim.api.nvim_buf_get_name(item.bufnr)
          return Path:new(path):make_relative(vim.loop.cwd())
        end,
      }, function(choice)
        if choice == nil then
          return
        end

        if choice.select then
          choice.select()
        else
          vim.api.nvim_set_current_buf(choice.bufnr)
        end
      end)
    end

    vim.keymap.set('n', '<leader>ht', open_switcher, { desc = '[H]arpoon [T]oggle quick menu' })
  end,
}

-- vim: ts=2 sts=2 sw=2 et
