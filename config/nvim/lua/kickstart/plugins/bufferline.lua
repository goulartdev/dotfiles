return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = {
    'echasnovski/mini.icons',
  },
  config = function()
    local bufferline = require 'bufferline'

    bufferline.setup {
      options = {
        always_show_bufferline = true,
        close_command = function(n)
          require('mini.bufremove').delete(n, false)
        end,
        diagnostics = 'nvim_lsp',
        hover = { enabled = false },
        separator_style = { '', '' },
        show_buffer_icons = false,
        show_buffer_close_icons = false,
        show_close_icon = false,
        tab_size = 1,
        themable = true,
        groups = {
          options = {
            toggle_hidden_on_enter = false,
          },
          items = {
            bufferline.groups.builtin.pinned:with {
              icon = '󰐃',
            },
            {
              id = 'modified',
              name = 'modified',
              priority = 2,
              hidden = false,
              auto_close = false,
              matcher = function(buf)
                return buf.modified
              end,
              separator = {
                style = bufferline.groups.separator.none,
              },
            },
            {
              id = 'current',
              name = 'current',
              priority = 3,
              hidden = false,
              auto_close = false,
              matcher = function(buf)
                return vim.fn.bufwinnr(buf.id) > -1
              end,
              separator = {
                style = bufferline.groups.separator.none,
              },
            },
            bufferline.groups.builtin.ungrouped:with {
              priority = 4,
              hidden = true,
              auto_close = false,
              separator = {
                style = function(_, hls, count)
                  return {
                    sep_start = {
                      { text = ' ', highlight = hls.fill.hl_group },
                      {
                        text = ' ' .. count:match '%d+' .. ' ',
                        highlight = hls.group_label.hl_group,
                      },
                    },
                    sep_end = {},
                  }
                end,
              },
            },
          },
        },
      },
    }

    for i = 1, 9, 1 do
      vim.keymap.set('n', 'g' .. i, function()
        bufferline.go_to(i, true)
      end, { desc = '[G]o to buffer [' .. i .. ']' })
    end

    vim.keymap.set('n', ']b', '<cmd>BufferLineCycleNext<cr>', { desc = 'Go to next buffer' })
    vim.keymap.set('n', '[b', '<cmd>BufferLineCyclePrev<cr>', { desc = 'Go to previous buffer' })
    vim.keymap.set('n', ']B', '<cmd>BufferLineMoveNext<cr>', { desc = 'Buffer Move to next' })
    vim.keymap.set('n', '[B', '<cmd>BufferLineMovePrev<cr>', { desc = 'Buffer Move to prev' })
    vim.keymap.set('n', '<leader>bp', '<cmd>BufferLineTogglePin<cr>', { desc = 'Buffer toggle Pin' })
    vim.keymap.set('n', '<leader>bc', '<cmd>BufferLineGroupClose ungrouped<cr>', { desc = 'Buffer Close all hidden' })
  end,
}
