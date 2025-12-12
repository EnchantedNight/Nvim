vim.api.nvim_create_autocmd({ "BufNewFile", "BufEnter" }, {
	pattern = "*",
	callback = function()
		if vim.fn.expand("%") == "" then
			local default_name = "[New]"
			vim.cmd("file " .. default_name)
		end
	end,
})
