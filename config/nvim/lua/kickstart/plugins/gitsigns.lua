return {
  'lewis6991/gitsigns.nvim',
  opts = {
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },
    current_line_blame_opts = {
      delay = 0,
    },
    preview_config = {
      border = 'rounded',
    },
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      map('n', ']h', function()
        if vim.wo.diff then
          return ']h'
        end
        vim.schedule(function()
          gs.next_hunk()
        end)
        return '<Ignore>'
      end, { expr = true, desc = 'Next Hunk' })

      map('n', '[h', function()
        if vim.wo.diff then
          return '[h'
        end
        vim.schedule(function()
          gs.prev_hunk()
        end)
        return '<Ignore>'
      end, { expr = true, desc = 'Previous Hunk' })

      map('n', '<leader>gb', gs.toggle_current_line_blame, { desc = 'Git Blame line' })
      map('n', '<leader>hs', gs.stage_hunk, { desc = 'Hunk Stage' })
      map('n', '<leader>hr', gs.reset_hunk, { desc = 'Hunk Reset' })
      map('v', '<leader>hs', function()
        gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, { desc = 'Hunk Stage' })
      map('v', '<leader>hr', function()
        gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, { desc = 'Hunk Reset' })
      -- map('n', '<leader>hS', gs.stage_buffer, {desc = "Hunk Stage"})
      map('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'Hunk stage Undo' })
      -- map('n', '<leader>hR', gs.reset_buffer, {desc = "Hunk Stage"})
      map('n', '<leader>hp', gs.preview_hunk, { desc = 'Hunk Preview' })
      map('n', '<leader>hb', function()
        gs.blame_line { full = true }
      end, { desc = 'Hunk Blame' })
      -- map('n', '<leader>hd', gs.diffthis, { desc = 'Hunk Diff' })
      -- map('n', '<leader>hD', function() gs.diffthis '~' end, { desc = 'Hunk Diff ~' })
      -- map('n', '<leader>td', gs.toggle_deleted)

      map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'Select hunk under the cursor' })
      map({ 'o', 'x' }, 'ah', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'Select hunk under the cursor' })
    end,
  },
}

-- vim: ts=2 sts=2 sw=2 et
