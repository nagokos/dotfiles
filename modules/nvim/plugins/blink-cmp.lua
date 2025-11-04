require("blink.cmp").setup({
	sources = {
		default = { "lsp", "path", "buffer", "snippets" },
	},
	completion = {
		list = {
			selection = { preselect = false },
		},
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 100,
			treesitter_highlighting = false,
			window = {
				border = "rounded",
				winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
			},
		},
		menu = {
			border = "rounded",
			winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
		},
	},
	signature = {
		enabled = false,
	},
	keymap = {
		preset = "none",
		["<CR>"] = { "accept", "fallback" },

		["<Up>"] = false,
		["<Down>"] = false,
		["<C-p>"] = { "select_prev", "fallback_to_mappings" },
		["<C-n>"] = { "select_next", "fallback_to_mappings" },

		["<Tab>"] = { "snippet_forward", "fallback" },
		["<S-Tab>"] = { "snippet_backward", "fallback" },

		["<C-b>"] = { "scroll_documentation_up", "fallback" },
		["<C-f>"] = { "scroll_documentation_down", "fallback" },
	},
	cmdline = {
		completion = {
			menu = { auto_show = true },
			list = {
				selection = { preselect = false },
			},
		},
		keymap = {
			preset = "none",
			["<CR>"] = { "accept", "fallback" },

			["<Up>"] = false,
			["<Down>"] = false,
			["<C-p>"] = { "select_prev", "fallback_to_mappings" },
			["<C-n>"] = { "select_next", "fallback_to_mappings" },
		},
	},
})
