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
    [".*/zsh/functions/.*"] = "sh",
    [".*.conf.template"] = "nginx",
    [".*/dotfiles/scripts/.*"] = "sh",
  },
})

vim.opt.autowrite = false
vim.opt.linebreak = false
vim.opt.wrap = true
