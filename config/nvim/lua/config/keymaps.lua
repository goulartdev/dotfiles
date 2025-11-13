local map = vim.keymap.set
local unmap = vim.keymap.del

map("n", "<C-c>", "<cmd>bw<cr>", { desc = "Close current buffer" })

map("n", "<C-d>", "<C-d>zz", { desc = "Scroll halfscreen down and center current line" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll halfscreen aup nd center current line" })

map("n", "<leader>rw", [[:%s/\<<C-r><C-w>\>//gI<Left><Left><Left>]], { desc = "Replace current Word" })

map("n", "<leader><space>", LazyVim.pick("files", { hidden = true }), { desc = "Find Files (Root Dir)" })
map("n", "<leader>s.", function() Snacks.picker.recent({ filter = { cwd = true }}) end, {desc = "Recent (cwd)"})

unmap("n", "<leader>fT")
unmap("n", "<leader>ft")
unmap({ "n", "t" }, "<c-/>")
unmap({ "n", "t" }, "<c-_>")
unmap("n", "<leader>fR")
