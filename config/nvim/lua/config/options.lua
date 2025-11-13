-- --------------------------------------------------------------
-- Lazyvim Optional Extras
-- --------------------------------------------------------------

-- vim.g.lazyvim_mini_snippets_in_completion = true

-- --------------------------------------------------------------
-- My options
-- --------------------------------------------------------------

vim.opt.relativenumber = true

-- Sets how neovim will display certain whitespace in the editor.
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- vim.diagnostic.config {
--   signs = {
--     active = true,
--     text = {
--       [vim.diagnostic.severity.ERROR] = ' ',
--       [vim.diagnostic.severity.WARN] = ' ',
--       [vim.diagnostic.severity.INFO] = ' ',
--       [vim.diagnostic.severity.HINT] = '󰌶 ',
--     },
--     numhl = {
--       [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
--       [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
--       [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
--       [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
--     },
--   },
--   virtual_text = false,
--   update_in_insert = false,
--   underline = true,
--   severity_sort = true,
--   float = {
--     focusable = true,
--     style = 'minimal',
--     border = 'rounded',
--     source = 'if_many',
--     header = '',
--     prefix = '',
--   },
-- }

vim.opt.fillchars:append({ diff = "⋰" })

vim.opt.sessionoptions = {
  "buffers",
  "curdir",
  "tabpages",
  "winsize",
  "help",
  "globals",
  "skiprtp",
  "folds",
  "blank",
  "winpos",
  "localoptions",
}

vim.filetype.add({
  pattern = {
    [".*.conf.template"] = "nginx",
    [".*/zsh/functions/.*"] = "sh",
  },
})

vim.opt.autowrite = false
vim.opt.linebreak = false
vim.opt.wrap = true
