return {
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-ui-select.nvim',
      'nvim-tree/nvim-web-devicons',
      'debugloop/telescope-undo.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      { 'AckslD/nvim-neoclip.lua', opts = {} },
    },
    config = function()
      local telescope = require 'telescope'

      local function detach_buffer(force)
        return function(prompt_bufnr)
          local current_picker = require('telescope.actions.state').get_current_picker(prompt_bufnr)
          current_picker:delete_selection(function(selection)
            return pcall(vim.api.nvim_buf_delete, selection.bufnr, { force = force })
          end)
        end
      end

      telescope.setup {
        defaults = {
          mappings = {
            n = {
              ['<C-c>'] = require('telescope.actions').close,
            },
          },
        },
        pickers = {
          buffers = {
            mappings = {
              n = {
                ['d'] = { detach_buffer(false), opts = { desc = 'detach buffer' } },
                ['D'] = { detach_buffer(true), opts = { desc = 'force detach buffer' } },
              },
            },
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable telescope extensions, if they are installed
      pcall(telescope.load_extension, 'fzf')
      pcall(telescope.load_extension, 'ui-select')
      pcall(telescope.load_extension, 'neoclip')
      pcall(telescope.load_extension, 'undo')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
      vim.keymap.set('n', '<leader>sn', '<cmd>Telescope notify<cr>', { desc = '[S]earch [N]otifications' })
      vim.keymap.set('n', '<leader>sc', '<cmd>Telescope neoclip<cr>', { desc = '[S]earch [C]lipboard (neoclip)' })
      vim.keymap.set('n', '<leader>su', '<cmd>Telescope undo<cr>', { desc = '[S]earch [U]ndo tree' })
      vim.keymap.set('n', '<leader>sm', builtin.git_status, { desc = '[S]earch [M]odified files (git status)' })

      vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })
    end,
  },
}

-- vim: ts=2 sts=2 sw=2 et
