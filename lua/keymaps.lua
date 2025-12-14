local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<Up>", "gk", opts)
vim.keymap.set("n", "<Down>", "gj", opts)

vim.keymap.set("i", "<Up>", "<Up>", opts)
vim.keymap.set("i", "<Down>", "<Down>", opts)

vim.keymap.set("v", "<Up>", "gk", opts)
vim.keymap.set("v", "<Down>", "gj", opts)

vim.keymap.set("n", "<S-Up>", "v<Up>", opts)
vim.keymap.set("n", "<S-Down>", "v<Down>", opts)

vim.keymap.set("v", "<S-Up>", "<Up>", opts)
vim.keymap.set("v", "<S-Down>", "<Down>", opts)

vim.api.nvim_set_keymap("v", "<leader>d", '"_d', opts)

vim.api.nvim_set_keymap("v", "<leader>e", '"+d', opts)

-- Delete current line
vim.keymap.set("n", "<C-x>", "_dd", opts)

-- Alt+I - Insert
vim.api.nvim_set_keymap("n", "<A-i>", "i", opts)

-- Alt+V - Visual
vim.api.nvim_set_keymap("n", "<A-v>", "v", opts)

vim.api.nvim_set_keymap("v", "<leader>y", ":w !wl-copy<CR><CR>", opts)

vim.api.nvim_set_keymap("n", "<leader>p", ":r !wl-paste<CR><CR>", opts)

vim.api.nvim_set_keymap("n", "<C-z>", "u", opts)

vim.api.nvim_set_keymap("n", "<C-y>", "<C-r>", opts)

vim.api.nvim_set_keymap("i", "<C-z>", "<C-o>u", opts)
vim.api.nvim_set_keymap("i", "<C-y>", "<C-o><C-r>", opts)

vim.api.nvim_set_keymap("n", "<C-e>", ":Oil<CR>", opts)

vim.keymap.set({ "n", "t" }, "<C-`>", function()
	if vim.b.toggle_number then
		require("toggleterm.terminal").get(vim.b.toggle_number):shutdown()
	else
		require("toggleterm.terminal").Terminal:new():open()
	end
end, opts)
