return {
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
              ['d'] = { wipeout_buffer(false), type = 'action', opts = { desc = 'wipeout buffer' } },
              ['D'] = { wipeout_buffer(true), type = 'action', opts = { desc = 'force wipeout buffer' } },
              ['w'] = { write_buffer, type = 'action', opts = { desc = 'write buffer' } },
              ['W'] = { '<cmd>wall<cr>', type = 'command', opts = { desc = 'write all buffers' } },
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

    pcall(telescope.load_extension, 'fzf')
    pcall(telescope.load_extension, 'ui-select')
    pcall(telescope.load_extension, 'neoclip')
    pcall(telescope.load_extension, 'undo')

    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>sn', '<cmd>Telescope notify<cr>', { desc = '[S]earch [N]otifications' })
    vim.keymap.set('n', '<leader>sc', '<cmd>Telescope neoclip<cr>', { desc = '[S]earch [C]lipboard (neoclip)' })
    vim.keymap.set('n', '<leader>su', '<cmd>Telescope undo<cr>', { desc = '[S]earch [U]ndo tree' })
    vim.keymap.set('n', '<leader>sm', builtin.git_status, { desc = '[S]earch [M]odified files (git status)' })

    vim.keymap.set('n', '<leader><leader>', function()
      builtin.buffers(require('telescope.themes').get_dropdown {
        previewer = false,
        initial_mode = 'normal',
      })
    end, { desc = '[ ] Find existing buffers' })

    vim.keymap.set('n', '<leader>/', function()
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })
  end,
}

-- vim: ts=2 sts=2 sw=2 et
