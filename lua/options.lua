local M = {}

vim.opt.number = true

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.backspace = "2"
vim.opt.autowrite = true
vim.opt.autoread = true

vim.opt.shiftround = true

vim.opt.signcolumn = "yes"

vim.opt.cursorline = true

vim.opt.list = true
vim.opt.listchars = {
	tab = "» ",
	trail = "·",
	nbsp = "␣",
}

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.inccommand = "split"

vim.opt.wrap = true
vim.opt.breakindent = true

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 4

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.undofile = true

vim.opt.winborder = "rounded"

vim.g.have_nerd_font = true

vim.o.showmode = true
vim.o.laststatus = 4
vim.o.showcmd = true
vim.o.cmdheight = 0
vim.opt.ruler = false

vim.opt.clipboard = "unnamedplus"

function M.Fmode()
	local mode = vim.fn.mode()
	if mode == "n" then
		return "NORMAL"
	elseif mode == "i" then
		return "INSERT"
	elseif mode == "v" then
		return "VISUAL"
	elseif mode == "V" then
		return "V-LINE"
	elseif mode == "^V" then
		return "V-BLOCK"
	elseif mode == "c" then
		return "COMMAND"
	elseif mode == "t" then
		return "NORMAL"
	else
		return mode:upper()
	end
end

vim.opt.statusline = " %{v:lua.require'options'.Fmode()} %=%{strftime('%H:%M')} "

return M
