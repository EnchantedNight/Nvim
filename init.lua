require("keymaps")
require("options")

vim.pack.add({
	{ src = "https://github.com/folke/tokyonight.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/windwp/nvim-autopairs" },
	{ src = "https://github.com/numToStr/Comment.nvim" },
	{ src = "https://github.com/akinsho/toggleterm.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{
		src = "https://github.com/saghen/blink.cmp",
		-- cargo +nightly build --release
	},
	{ src = "https://github.com/stevearc/oil.nvim" },
})

require("tokyonight").setup({
	style = "night",
	transparent = false,
	styles = {
		comments = { italic = true },
		keywords = { italic = true },
	},
})

vim.cmd("colorscheme tokyonight")
vim.cmd(":hi statusline guibg=NONE")

vim.lsp.enable({
	"lua_ls",
	"clangd",
	"rust_analyzer",
})

vim.diagnostic.config({
	virtual_lines = {
		current_line = true,
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.INFO] = " ",
			[vim.diagnostic.severity.HINT] = " ",
		},
	},
})

require("oil").setup()
require("nvim-autopairs").setup()

require("conform").setup({
	format_on_save = {
		lsp_fallback = true,
		timeout_ms = 500,
	},

	formatters_by_ft = {
		c = { "clang_format" },
		lua = { "stylua" },
		rs = { "rustfmt" },
	},
})

require("Comment").setup({
	toggler = {
		line = "<leader>c",
		block = "<leader>b",
	},
	opleader = {
		line = "<leader>c",
		block = "<leader>b",
	},
})

require("nvim-treesitter.configs").setup({
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	ensure_installed = {
		"c",
		"lua",
		"rust",
	},
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	indent = {
		enable = true,
	},
})

require("blink.cmp").setup({
	signature = { enabled = true },
	sources = {
		default = { "lsp" },
	},
	completion = {
		menu = {
			scrollbar = false,
		},
	},
})

require("toggleterm").setup({
	direction = "float",
	start_in_insert = true,
	close_on_exit = true,
	float_opts = {
		border = "rounded",
	},
})
