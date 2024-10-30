require("blink.cmp").setup({
	keymap = {
		show = "<C-space>",
		hide = "<C-y>",
		accept = "<CR>",
		select_prev = { "<C-p>" },
		select_next = { "<C-n>" },

		scroll_documentation_up = "<C-b>",
		scroll_documentation_down = "<C-f>",

		snippet_forward = "<Tab>",
		snippet_backward = "<S-Tab>",
	},

	trigger = {
		completion = {
			keyword_range = "prefix",
			keyword_regex = "[%w_\\-]",
			exclude_from_prefix_regex = "[\\-]",
			blocked_trigger_characters = { " ", "\n", "\t" },
			show_on_insert_on_trigger_character = true,
			show_on_insert_blocked_trigger_characters = { "'", '"' },
			show_in_snippet = false,
		},

		signature_help = {
			enabled = true,
			blocked_trigger_characters = {},
			blocked_retrigger_characters = {},
			show_on_insert_on_trigger_character = true,
		},
	},

	fuzzy = {
		use_frecency = true,
		use_proximity = true,
		max_items = 200,
		sorts = { "label", "kind", "score" },

		prebuiltBinaries = {
			download = true,
			forceVersion = nil,
		},
	},

	sources = {
		completion = {
			enabled_providers = { "lsp", "path", "snippets", "buffer" },
		},

		providers = {
			lsp = {
				name = "LSP",
				module = "blink.cmp.sources.lsp",

				enabled = true, -- whether or not to enable the provider
				transform_items = nil, -- function to transform the items before they're returned
				should_show_items = true, -- whether or not to show the items
				max_items = nil, -- maximum number of items to return
				min_keyword_length = 0, -- minimum number of characters to trigger the provider
				fallback_for = {}, -- if any of these providers return 0 items, it will fallback to this provider
				score_offset = 0, -- boost/penalize the score of the items
				override = nil, -- override the source's functions
			},
			path = {
				name = "Path",
				module = "blink.cmp.sources.path",
				score_offset = 3,
				opts = {
					trailing_slash = false,
					label_trailing_slash = true,
					get_cwd = function(context)
						return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
					end,
					show_hidden_files_by_default = false,
				},
			},
			snippets = {
				name = "Snippets",
				module = "blink.cmp.sources.snippets",
				score_offset = -3,
				opts = {
					friendly_snippets = true,
					search_paths = { vim.fn.stdpath("config") .. "/snippets" },
					global_snippets = { "all" },
					extended_filetypes = {},
					ignored_filetypes = {},
				},
			},
			buffer = {
				name = "Buffer",
				module = "blink.cmp.sources.buffer",
				fallback_for = { "lsp" },
			},
		},
	},

	windows = {
		autocomplete = {
			min_width = 15,
			max_height = 10,
			border = "rounded",
			winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
			scrolloff = 2,
			direction_priority = { "s", "n" },
			selection = "preselect",
			draw = "simple",
			cycle = {
				from_bottom = true,
				from_top = true,
			},
		},
		documentation = {
			min_width = 10,
			max_width = 60,
			max_height = 20,
			border = "rounded",
			winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
			direction_priority = {
				autocomplete_north = { "e", "w", "n", "s" },
				autocomplete_south = { "e", "w", "s", "n" },
			},
			auto_show = false,
			auto_show_delay_ms = 500,
			update_delay_ms = 50,
		},
		signature_help = {
			min_width = 1,
			max_width = 100,
			max_height = 10,
			border = "rounded",
			winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
		},
	},

	highlight = {
		ns = vim.api.nvim_create_namespace("blink_cmp"),
		use_nvim_cmp_as_default = true,
	},

	nerd_font_variant = "normal",

	kind_icons = {
		Text = "󰉿",
		Method = "󰊕",
		Function = "󰊕",
		Constructor = "󰒓",

		Field = "󰜢",
		Variable = "󰆦",
		Property = "󰖷",

		Class = "󱡠",
		Interface = "󱡠",
		Struct = "󱡠",
		Module = "󰅩",

		Unit = "󰪚",
		Value = "󰦨",
		Enum = "󰦨",
		EnumMember = "󰦨",

		Keyword = "󰻾",
		Constant = "󰏿",

		Snippet = "󱄽",
		Color = "󰏘",
		File = "󰈔",
		Reference = "󰬲",
		Folder = "󰉋",
		Event = "󱐋",
		Operator = "󰪚",
		TypeParameter = "󰬛",
	},
})
