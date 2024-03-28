return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-ui-select.nvim',
    'nvim-tree/nvim-web-devicons',
    'debugloop/telescope-undo.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
    },
    {
      'AckslD/nvim-neoclip.lua',
      opts = { default_register = '+' },
    },
  },
  config = function()
    local telescope = require 'telescope'

    local function wipeout_buffer(force)
      return function(prompt_bufnr)
        local picker = require('telescope.actions.state').get_current_picker(prompt_bufnr)
        picker:delete_selection(function(selection)
          return pcall(vim.api.nvim_buf_delete, selection.bufnr, { force = force })
        end)
      end
    end

    local function write_buffer(prompt_bufnr)
      local picker = require('telescope.actions.state').get_current_picker(prompt_bufnr)
      local selections = picker:get_multi_selection()

      if vim.tbl_isempty(selections) then
        table.insert(selections, picker:get_selection())
      end

      for _, selection in ipairs(selections) do
        vim.api.nvim_buf_call(selection.bufnr, function()
          vim.cmd 'write'
        end)
      end
    end

    telescope.setup {
      pickers = {
        buffers = {
          mappings = {
            n = {
              ['d'] = { wipeout_buffer(false), type = 'action', opts = { desc = 'Wipeout Buffer' } },
              ['D'] = { wipeout_buffer(true), type = 'action', opts = { desc = 'Force Wipeout Buffer' } },
              ['w'] = { write_buffer, type = 'action', opts = { desc = 'Write Buffer' } },
              ['W'] = { '<cmd>wall<cr>', type = 'command', opts = { desc = 'write all buffers' } },
            },
          },
        },
        find_files = {
          find_command = { 'fd', '--type', 'f', '--color', 'never', '--hidden', '--exclude', '.git' },
        },
        grep_string = {
          find_command = { 'rg', '--file', '--color', 'never', '--hidden', '-g', '!.git/*' },
        },
        live_grep = {
          additional_args = { '--hidden', '-g', '!.git/*' },
        },
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    }

    pcall(telescope.load_extension, 'fzf')
    pcall(telescope.load_extension, 'ui-select')
    pcall(telescope.load_extension, 'neoclip')
    pcall(telescope.load_extension, 'undo')

    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'Search Help' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = 'Search Keymaps' })
    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = 'Search Files' })
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = 'Search current Word' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'Search by Grep' })
    vim.keymap.set('n', '<leader>sc', '<cmd>Telescope neoclip default<cr>', { desc = 'Search Clipboard' })
    vim.keymap.set('n', '<leader>sC', builtin.command_history, { desc = 'Search Command history' })
    vim.keymap.set('n', '<leader>su', '<cmd>Telescope undo<cr>', { desc = 'Search Undo tree' })
    vim.keymap.set('n', '<leader>.', builtin.resume, { desc = 'Telescope search resume' })

    vim.keymap.set('n', '<leader><leader>', function()
      builtin.buffers(require('telescope.themes').get_dropdown {
        previewer = false,
        initial_mode = 'normal',
      })
    end, { desc = 'find existing buffers' })

    vim.keymap.set('n', '<leader>/', function()
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        previewer = false,
      })
    end, { desc = 'fuzzily search in current buffer' })

    vim.keymap.set('n', '<leader>gl', builtin.git_bcommits, { desc = 'Git Logs (buffer)' })
    vim.keymap.set('n', '<leader>gL', builtin.git_commits, { desc = 'Git Logs (branch)' })
    vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = 'Git Status' })
    vim.keymap.set('n', '<leader>gB', builtin.git_branches, { desc = 'Git Branches' })
  end,
}

-- vim: ts=2 sts=2 sw=2 et
