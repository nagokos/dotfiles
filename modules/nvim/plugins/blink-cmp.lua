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
		["<CR>"] = { "select_and_accept", "fallback" },

		["<Up>"] = false,
		["<Down>"] = false,
		["<C-p>"] = { "select_prev", "fallback_to_mappings" },
		["<C-n>"] = { "select_next", "fallback_to_mappings" },

		["<C-k>"] = { "hide", "fallback" },

		["<Tab>"] = { "snippet_forward", "fallback" },
		["<S-Tab>"] = { "snippet_backward", "fallback" },

		["<C-u>"] = { "scroll_documentation_up", "fallback" },
		["<C-d>"] = { "scroll_documentation_down", "fallback" },
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
			-- ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
			-- ["<C-n>"] = { "select_next", "fallback_to_mappings" },
			["<C-k>"] = { "cancel", "fallback" },

			["<C-n>"] = { "show_and_insert_or_accept_single", "select_next" },
			["<C-p>"] = { "show_and_insert_or_accept_single", "select_prev" },
		},
	},
})
