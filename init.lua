require("autocmds")
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
		dependencies = { "hrsh7th/nvim-cmp" },
		-- build = "cargo +nightly build --release",
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

vim.lsp.config("vtsls", {
	settings = {
		vtsls = {
			tsserver = {
				globalPlugins = {
					{
						name = "@vue/typescript-plugin",
						location = "/usr/lib/node_modules/@vue/typescript-plugin",
						languages = { "vue" },
						configNamespace = "typescript",
					},
				},
			},
		},
	},
	filetypes = {
		"typescript",
		"javascript",
		"vue",
	},
})

vim.lsp.config("vue_ls", {
	settings = {
		init_options = {
			typescript = {
				tsdk = "",
			},
		},
	},
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snipperSupport = true

vim.lsp.config("cssls", {
	filetypes = { "css", "scss" },
	capabilities = capabilities,
	settings = {
		css = {
			validate = true,
		},
		scss = {
			validate = true,
		},
	},
})

vim.lsp.config("html", {
	filetypes = { "html" },
	capabilities = capabilities,
	settings = {
		html = {
			format = {
				enable = true,
				wrapLineLength = 120,
				wrapAttributes = "auto",
			},
			hover = {
				documentation = true,
				references = true,
			},
			validate = { scripts = true, styles = true },
		},
	},
})

vim.lsp.config("tailwindcss", {
	filetypes = {
		"html",
		"css",
		"typescript",
		"javascript",
		"vue",
	},
	settings = {
		validate = false,
		tailwindCSS = {
			includeLanguages = {
				html = "html",
				vue = "vue",
			},
		},
	},
})

vim.lsp.enable({
	"html",
	"cssls",
	"lua_ls",
	"clangd",
	"tailwindcss",
	"vue_ls",
	"vtsls",
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
			vim.opt.completeopt = { "menu", "menuone", "noinsert", "fuzzy", "popup" }
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
			vim.keymap.set("i", "<C-Space>", function()
				vim.lsp.completion.get()
			end)
		end
	end,
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

vim.cmd("colorscheme tokyonight")
vim.cmd(":hi statusline guibg=NONE")

require("oil").setup()

require("conform").setup({
	format_on_save = {
		lsp_fallback = true,
		timeout_ms = 500,
	},

	formatters_by_ft = {
		javascript = { "prettier" },
		typescript = { "prettier" },
		vue = { "prettier" },
		c = { "clang_format" },
		lua = { "stylua" },
		css = { "prettier" },
		scss = { "prettier" },
		html = { "prettier" },
	},
})

require("nvim-autopairs").setup()

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
		"vue",
		"lua",
		"javascript",
		"typescript",
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
	appearance = {
		use_nvim_cmp_as_default = false,
		nerd_font_variant = "normal",
	},
	sources = {
		default = { "lsp" },
	},
	cmdline = {
		enabled = false,
	},
	completion = {
		menu = {
			border = nil,
			scrolloff = 1,
			scrollbar = false,
			draw = {
				columns = {
					{ "kind_icon" },
					{ "label", "label_description", gap = 1 },
					{ "kind" },
					{ "source_name" },
				},
			},
		},
		documentation = {
			window = {
				border = nil,
				scrollbar = false,
				winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc",
			},
			auto_show = true,
			auto_show_delay_ms = 500,
		},
	},
	keymap = {
		[""] = {},
	},
})

require("toggleterm").setup({
	direction = "float",
	start_in_insert = true,
	close_on_exit = true,
	persist_mode = false,
	float_opts = {
		border = "rounded",
	},
})

local Terminal = require("toggleterm.terminal").Terminal
local float_term = Terminal:new({
	direction = "float",
	hidden = true,
})

vim.keymap.set({ "n", "t" }, "<C-`>", function()
	float_term:toggle()
end, { noremap = true, silent = true })
